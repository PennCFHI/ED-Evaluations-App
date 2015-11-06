//
//  QRCodeViewController.h
//  EmergencyEvals
//
//  Created by David Rub on 10/29/15.
//  Copyright © 2015 poloclub. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <Foundation/Foundation.h>
#import <ParseUI/ParseUI.h>
#import <CoreImage/CoreImage.h>
#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>

@class PFUser;


@interface QRCodeViewController : UIViewController

@property (strong, nonatomic) NSString *userID;
@property (strong, nonatomic) UIButton *backButton;
@property (strong, nonatomic) UIImage *QRCode;
@property (strong, nonatomic) UIImageView *QRImageView;


-(IBAction)returnToMain:(id)sender;


@end






