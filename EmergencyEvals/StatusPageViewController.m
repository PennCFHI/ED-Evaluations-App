//
//  StatusPageViewController.m
//  EmergencyEvals
//
//  Created by David Rub on 11/2/15.
//  Copyright © 2015 poloclub. All rights reserved.
//

#import "StatusPageViewController.h"

@implementation StatusPageViewController

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewDidLoad{
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,140,self.view.frame.size.width - 40,30)];
    [self.timeLabel setText:@"QR Code Reader is not yet running..."];
    [self.timeLabel setFont:[UIFont systemFontOfSize:20.0]];
    [self.timeLabel setTextAlignment: NSTextAlignmentCenter];
    [self.view addSubview:self.timeLabel];

    self.startStopButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 200/2, self.view.frame.size.height - 60, 200, 50)];
    [self.startStopButton setTitle:@"Start Shift" forState:UIControlStateNormal];
    [self.startStopButton setBackgroundColor:[UIColor blackColor]];
    [self.startStopButton addTarget:self action:@selector(startPressed:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.startStopButton];
}

-(IBAction)startPressed:(id)sender{
    NSLog(@"Start Shift Pressed");
    NSLog(@"resident list: %@", self.residentList);
    
    
}

-(void)updateTimer{
    
}

@end
