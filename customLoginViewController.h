//
//  customLoginViewController.h
//  EmergencyEvals
//
//  Created by David Rub on 1/14/16.
//  Copyright © 2016 poloclub. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface customLoginViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *password;

-(IBAction)logIn:(id)sender;
-(IBAction)signUp:(id)sender;
-(IBAction)cancel:(id)sender; 
@end
