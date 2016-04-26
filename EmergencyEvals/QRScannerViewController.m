//
//  QRScannerViewController.m
//  EmergencyEvals
//
//  Created by David Rub on 10/31/15.
//  Copyright © 2015 poloclub. All rights reserved.
//

#import "QRScannerViewController.h"

//alert view tags
#define TAG_CONTINUE 1

@implementation QRScannerViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

-(void)viewDidLoad{
    [super viewDidLoad];
  
    
    //when view loads scanner should not be reading
    self.isReading = NO;
    self.captureSession = nil;
    
    //declare all frame and visual properties
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.scannerFrame = [[UIView alloc] initWithFrame:CGRectMake(20, 80, self.view.frame.size.width - 40, self.view.frame.size.width - 40)];
    [self.scannerFrame setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:self.scannerFrame];
    
    self.scannerInsructionLabel = [[UILabel alloc] initWithFrame:CGRectMake(17, 140, self.scannerFrame.frame.size.width - 34, 21)];
    [self.scannerInsructionLabel setTextColor:[UIColor whiteColor]];
    [self.scannerInsructionLabel setNumberOfLines:2];
    [self.scannerInsructionLabel setText:@"Press 'Begin' to Start Scanning Residents"];
    [self.scannerInsructionLabel setFont:[UIFont systemFontOfSize:15.0]];
    [self.scannerInsructionLabel setTextAlignment: NSTextAlignmentCenter];
 
  
    [self.scannerFrame addSubview:self.scannerInsructionLabel];
    
    
    
    self.scannerCommand = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 200/2, self.view.frame.size.height - 60, 200, 50)];
    [self.scannerCommand setTitle:@"Begin" forState:UIControlStateNormal];
    [self.scannerCommand setBackgroundColor:[UIColor blackColor]];
    [self.scannerCommand addTarget:self action:@selector(startStopScan:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.scannerCommand];
    
    
    //status dimensions so it is always 1/2 between the frame and the button
    self.scannerStatus = [[UILabel alloc] initWithFrame:CGRectMake(20,
                                                                   (self.scannerFrame.frame.origin.y + self.scannerFrame.frame.size.height + self.scannerCommand.frame.origin.y - 21)/2,self.view.frame.size.width - 40, 21)];
    [self.scannerStatus setTextColor:[UIColor greenColor]];
    [self.scannerStatus setBackgroundColor:[UIColor blackColor]];
    [self.scannerStatus setText:@"QR Code Reader is not yet running..."];
    [self.scannerStatus setFont:[UIFont systemFontOfSize:15.0]];
    [self.scannerStatus setTextAlignment: NSTextAlignmentLeft];
    [self.view addSubview:self.scannerStatus];
   
    UIBarButtonItem *continueButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Continue"
                                   style:UIBarButtonItemStyleDone
                                   target:self
                                   action:@selector(continueToStartShift:)];
    self.navigationItem.rightBarButtonItem = continueButton;
    
    self.residentQRList = [[NSMutableArray alloc] init];
    
    
}

-(IBAction)startStopScan:(id)sender{
    NSLog(@"start button pressed");
   // [self dismissViewControllerAnimated:YES completion:NULL];
    
    if (!self.isReading) {
        if ([self startReading]) {
            [self.scannerCommand setTitle:@"Cancel" forState:UIControlStateNormal];
            [self.scannerStatus setText:@"Scanning for Resident QR Code..."];
        }
    }
    else{
        [self stopReading];
       
        
    }
    
    _isReading = !_isReading;
    
}

-(IBAction)continueToStartShift:(id)sender{

    if (!_residentQRList || !_residentQRList.count){
        NSLog(@"button pressed without scanning");
        
        UIAlertView *theAlert = [[UIAlertView alloc] initWithTitle:@"No Residents Scanned!"
                                                           message:@"Please Scan at least 1 Resident QR before continuting."
                                                          delegate:self
                                                 cancelButtonTitle:@"OK"
                                                 otherButtonTitles:nil];
        [theAlert show];
        
    }
    
    else
    {
 
    NSLog(@"QR Codes Gained: %@", _residentQRList);
    
    UIAlertView *alert2 = [[UIAlertView alloc] initWithTitle:@"Are All Residents Scanned?"
                                                           message:@"If Yes, press 'Continue', otherwise please press 'Cancel' and Scan Again. "
                                                          delegate:self
                                                 cancelButtonTitle:@"Cancel"
                                                 otherButtonTitles:@"Continue", nil];
    [alert2 show];
     alert2.tag = TAG_CONTINUE;
   
        
    NSLog(@"continue button pressed with scanned QR Code ");
    }
    
}


-(BOOL)startReading{
    NSError *error;
    
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    
    if (!input) {
        NSLog(@"%@", [error localizedDescription]);
        return NO;
    }
    
    _captureSession = [[AVCaptureSession alloc] init];
    [_captureSession addInput:input];
    
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [_captureSession addOutput:captureMetadataOutput];
    
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("myQueue", NULL);
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
    
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [_videoPreviewLayer setFrame:_scannerFrame.layer.bounds];
    [_scannerFrame.layer addSublayer:_videoPreviewLayer];
    
    [_captureSession startRunning];
    
    return YES;
}

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
            //[_scannerStatus performSelectorOnMainThread:@selector(setText:) withObject:[metadataObj stringValue] waitUntilDone:YES];
            [_scannerStatus performSelectorOnMainThread:@selector(setText:) withObject:@"Resident Scanned Successfully!" waitUntilDone:YES];
            //adds data from QR code onto array residentQRList
            [self.residentQRList addObject:[metadataObj stringValue]];
            [self performSelectorOnMainThread:@selector(stopReading) withObject:nil waitUntilDone:NO];
            [_scannerCommand performSelectorOnMainThread:@selector(setTitle:) withObject:@"Start" waitUntilDone:NO];
            _isReading = NO;
        }
    }
    

    
    
    
}

-(void)stopReading{
    [_captureSession stopRunning];
    _captureSession = nil;
     [self.scannerCommand setTitle:@"Scan" forState:UIControlStateNormal];
    [_videoPreviewLayer removeFromSuperlayer];
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([[segue identifier] isEqualToString:@"scanToStatus"]){
        
       
        StatusPageViewController *statusPage = [segue destinationViewController];
        statusPage.residentList = [[NSMutableArray alloc] initWithArray:self.residentQRList];
         NSLog(@"self.residentQRList = %@", self.residentQRList);
        NSLog(@"statusPage.resdientList = %@", statusPage.residentList);

    }
    
}

- (void)alertView:(UIAlertView *)theAlert clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (theAlert.tag == TAG_CONTINUE) { // handle the altdev
        if (buttonIndex == 1) {
             [self performSegueWithIdentifier:@"scanToStatus" sender:self];
        }
        
    }
}


@end
