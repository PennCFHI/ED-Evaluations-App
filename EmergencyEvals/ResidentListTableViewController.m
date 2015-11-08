//
//  ResidentListTableViewController.m
//  EmergencyEvals
//
//  Created by David Rub on 11/7/15.
//  Copyright © 2015 poloclub. All rights reserved.
//

#import "ResidentListTableViewController.h"

@interface ResidentListTableViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSString *currentResidentName;

@end

@implementation ResidentListTableViewController

-(void) viewDidLoad{
    NSLog(@"loaded ResidentListTableViewController");
    
    [super viewDidLoad];
    self.currentResidentName = nil;
    //setup residentTableView
    NSArray *residentsToEvaluate;
    self.residentsToEvaluate = self.residentQRList;
    [self.residentTable reloadData];

    
}

// Set up residentTable
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.residentsToEvaluate.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"populating row %i with name %@", (int)indexPath.row, self.residentsToEvaluate[indexPath.row]);
    
    // Create resident cell
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:@"residentCell"
                             forIndexPath:indexPath];
    
    // Configure cell
    NSString *residentName = [self.residentsToEvaluate objectAtIndex:indexPath.row];
    cell.textLabel.text = residentName;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.currentResidentName = [self.residentsToEvaluate objectAtIndex:indexPath.row];
    [self.residentsToEvaluate removeObjectAtIndex:indexPath.row];
    NSLog(@"selected cell: %i, %@", (int)indexPath.row, self.currentResidentName);
    [self performSegueWithIdentifier:@"segueToEval" sender:self];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    NSLog(@"prepare for segue: %@ for %@", segue.identifier, self.currentResidentName);
    if ([[segue identifier] isEqualToString:@"segueToEval"]){
        
        QuestionViewController *evalForm = segue.destinationViewController;
        evalForm.residentsToEvaluate = [[NSMutableArray alloc] initWithArray:self.residentsToEvaluate];
        evalForm.currentResidentName = [[NSString alloc] initWithString:self.currentResidentName];
        evalForm.shiftDate = [[NSString alloc] initWithString:self.shiftDate];
    }
    
}
    

@end
