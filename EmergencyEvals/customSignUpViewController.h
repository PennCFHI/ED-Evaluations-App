//
//  customSignUpViewController.h
//  EmergencyEvals
//
//  Created by David Rub on 1/14/16.
//  Copyright © 2016 poloclub. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface customSignUpViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *pennID;
@property (strong, nonatomic) IBOutlet UITextField *username;

@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *password;

- (IBAction)signUp:(id)sender;
- (IBAction)cancel:(id)sender;


@end
