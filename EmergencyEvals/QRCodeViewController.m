//
//  QRCodeViewController.m
//  EmergencyEvals
//
//  Created by David Rub on 10/29/15.
//  Copyright © 2015 poloclub. All rights reserved.
//

#import "QRCodeViewController.h"

@implementation QRCodeViewController

-(void)viewWillAppear:(BOOL)animated{
    
   
    
}

-(void)viewDidLoad{
    
    int buttonWidth = 200;
    int buttonHeight = 50;
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.backButton = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width - buttonWidth)/2,
                                                                       (self.view.frame.size.height * 3/4),
                                                                       buttonWidth,
                                                                       buttonHeight)];
    [self.backButton setBackgroundColor:[UIColor blackColor]];
    [self.backButton setTitle:@"Back" forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(returnToMain:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.backButton];
    
    NSLog(@"User ID: %@", self.userID);
    
    //transform QR Code to make less blurry
    CIImage *input = [self createQRForString:self.userID]; // input image is 100 X 100
    CGAffineTransform transform = CGAffineTransformMakeScale(5.0f, 5.0f); // Scale by 5 times along both dimensions
    CIImage *output = [input imageByApplyingTransform: transform];
    
    
    //define image view with QR code as background 
    self.QRCode = [[UIImage alloc] initWithCIImage:output];
    
    self.QRImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 30, self.view.frame.size.width - 20, self.view.frame.size.height/2)];
    [self.QRImageView setImage:self.QRCode];
    [self.view addSubview:self.QRImageView];
    
    
    
}

- (CIImage *)createQRForString:(NSString *)qrString {
    NSData *stringData = [qrString dataUsingEncoding: NSISOLatin1StringEncoding];
    
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    
    
    
    return qrFilter.outputImage;
}

-(IBAction)returnToMain:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
    NSLog(@"back button pressed");
}

@end
