//
//  StatusPageViewController.h
//  EmergencyEvals
//
//  Created by David Rub on 11/2/15.
//  Copyright © 2015 poloclub. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResidentListTableViewController.h"


BOOL startWasPressed;

@interface StatusPageViewController : UIViewController

@property (strong, nonatomic) UIButton *startStopButton; //sender in tutorial code
@property (strong, nonatomic) NSMutableArray *residentList;
@property (strong, nonatomic) NSMutableString *residentName;
@property (strong, nonatomic) NSMutableArray *residentNames;
@property (strong, nonatomic) NSString *shiftDate;


-(IBAction)startPressed:(id)sender;


@end

