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

    self.startStopButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 200/2, self.view.frame.size.height/2 - 50/2, 200, 50)];
    [self.startStopButton setTitle:@"Start Shift" forState:UIControlStateNormal];
    [self.startStopButton setBackgroundColor:[UIColor greenColor]];
    [self.startStopButton addTarget:self action:@selector(startPressed:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.startStopButton];
    
    startWasPressed = false;
    
    _residentName = [[NSMutableString alloc] init];
    _residentNames = [[NSMutableArray alloc] init];
}

-(IBAction)startPressed:(id)sender{
    
    if(startWasPressed == false)
    {
        
        
        for (int i = 0; i < _residentList.count; i++)
        {
        //get name from Parse using PennID
        PFQuery *query = [PFQuery queryWithClassName:@"UserConfirmation"];
         [query whereKey:@"pennID" equalTo:self.residentList[i]];
         [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
             if (!object) {
                    NSLog(@"The getFirstObject request failed.");
                }
             else {
                 // The find succeeded.
               
                 NSString *nameFromParse = [NSString stringWithFormat:@"%@ %@", [object objectForKey:@"firstName"], [object objectForKey:@"lastName"]];
               NSLog(@"Successfully retrieved the object: %@", nameFromParse);
                 [_residentNames addObject:nameFromParse];
//                 _residentNames[i] = nameFromParse;
                 NSLog(@"Resident Names: %@", _residentNames);
                }
         }];
        };
        
        NSLog(@"start button was pressed");
        
        //store date information
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
        self.shiftDate = [dateFormatter stringFromDate:[NSDate date]];
        
        //change button properties to Stop
        [self.startStopButton setTitle:@"Stop Shift" forState:UIControlStateNormal];
        [self.startStopButton setBackgroundColor:[UIColor redColor]];
        startWasPressed = true;
    }
    else
    {
        [self performSegueWithIdentifier:@"statusToTable" sender:self];
        NSLog(@"resident names: %@", _residentNames);
        startWasPressed = false; 
    }
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([[segue identifier] isEqualToString:@"statusToTable"]){
        
        
        ResidentListTableViewController *residentTable = [segue destinationViewController];
        residentTable.residentQRList = [[NSMutableArray alloc] initWithArray:self.residentList];
        residentTable.residentNames = [[NSMutableArray alloc] initWithArray:self.residentNames];
        residentTable.shiftDate = [[NSString alloc] initWithString:self.shiftDate];
        NSLog(@"QR List to populate table: %@", residentTable.residentQRList);
        NSLog(@"date to transfer to table: %@", residentTable.shiftDate);
    }
    
}
@end
