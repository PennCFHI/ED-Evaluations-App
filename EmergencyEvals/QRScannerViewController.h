//
//  QRScannerViewController.h
//  EmergencyEvals
//
//  Created by David Rub on 10/31/15.
//  Copyright © 2015 poloclub. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <Foundation/Foundation.h>
#import <ParseUI/ParseUI.h>
#import <CoreImage/CoreImage.h>
#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>
#import "StatusPageViewController.h"


@class PFUser;



@interface QRScannerViewController : UIViewController <AVCaptureMetadataOutputObjectsDelegate>

@property (strong, nonatomic) IBOutlet UIView *scannerFrame;
@property (strong, nonatomic) UILabel *scannerInsructionLabel;
@property (strong, nonatomic) IBOutlet UILabel *scannerStatus;
@property (strong, nonatomic) IBOutlet UIButton *scannerCommand;

@property (nonatomic) BOOL isReading;
@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (strong, nonatomic) NSMutableArray *residentQRList;




-(IBAction)startStopScan:(id)sender;
-(IBAction)continueToStartShift:(id)sender;
-(BOOL)startReading;
-(void)stopReading;


@end
