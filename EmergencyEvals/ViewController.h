//
//  ViewController.h
//  EmergencyEvals
//
//  Created by David Rub on 10/24/15.
//  Copyright (c) 2015 poloclub. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <Foundation/Foundation.h>
#import <ParseUI/ParseUI.h>
#import "QRCodeViewController.h"
#import "QRScannerViewController.h"


@interface ViewController : UIViewController  <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>

@property (strong, nonatomic) UITextField *IDNumber;
@property (strong, nonatomic) UIButton *resign;
@property (strong, nonatomic) IBOutlet UILabel *testLabel;
@property (strong, nonatomic) UIButton *logOut;
@property (strong, nonatomic) UIButton *ScanResidentButton;
@property (strong, nonatomic) UIButton *showQRCodeButton;
@property (strong, nonatomic) NSString *pennID;
@property (strong, nonatomic) NSMutableArray *residentList;




-(IBAction)logOutOfThisApp:(id)sender;
-(IBAction)resignKeyboard:(id)sender;
-(IBAction)launchScanner:(id)sender;
-(IBAction)showQR:(id)sender;

@end
