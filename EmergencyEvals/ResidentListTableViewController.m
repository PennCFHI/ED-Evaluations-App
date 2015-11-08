//
//  ResidentListTableViewController.m
//  EmergencyEvals
//
//  Created by David Rub on 11/7/15.
//  Copyright © 2015 poloclub. All rights reserved.
//

#import "ResidentListTableViewController.h"

@interface ResidentListTableViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation ResidentListTableViewController

-(void) viewDidLoad{
    NSLog(@"loaded ResidentListTableViewController");
    
    [super viewDidLoad];
    //setup residentTableView
    
    NSArray *residentsToEvaluate;
    self.residentsToEvaluate = self.residentQRList;
    [self.residentTable reloadData];

    
}

// Set up residentTable
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"populating %i rows in the table", (int)self.residentsToEvaluate.count);
    return self.residentsToEvaluate.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"populating table at row %i with %@", (int)indexPath.row, self.residentsToEvaluate[indexPath.row]);
    
    // Create resident cell
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:@"residentCell"
                             forIndexPath:indexPath];
    
    // Configure cell
    NSString *residentName = [self.residentsToEvaluate objectAtIndex:indexPath.row];
    cell.textLabel.text = residentName;
    return cell;
}



@end
