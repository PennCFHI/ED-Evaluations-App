//
//  StatusPageViewController.h
//  EmergencyEvals
//
//  Created by David Rub on 11/2/15.
//  Copyright © 2015 poloclub. All rights reserved.
//

#import <UIKit/UIKit.h>

BOOL running;

@interface StatusPageViewController : UIViewController

@property (strong, nonatomic) UIButton *startStopButton; //sender in tutorial code
@property (strong, nonatomic) UILabel *timeLabel; //lbl in tutorial code
@property (strong, nonatomic) NSTimer *stopTimer;
@property (strong, nonatomic) NSDate *startDate;
@property (strong, nonatomic) NSMutableArray *residentList;

-(IBAction)startPressed:(id)sender;
-(void)updateTimer;

@end

