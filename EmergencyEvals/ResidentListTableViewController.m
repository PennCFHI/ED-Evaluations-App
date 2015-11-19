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
    self.residentsToEvaluate = self.residentQRList;
    [self.navigationItem setHidesBackButton:YES];
    [self.residentTable reloadData];

    
}

// Set up residentTable
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.residentsToEvaluate.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"populating row %i with name %@", (int)indexPath.row, self.residentNames[indexPath.row]);
    NSMutableString *residentName;
    // Create resident cell
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:@"residentCell"
                             forIndexPath:indexPath];

    // Configure cell
    residentName = [self.residentNames objectAtIndex:indexPath.row];
    cell.textLabel.text = residentName;
    NSLog(@"resident name is: %@", residentName);
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.currentResidentName = [self.residentsToEvaluate objectAtIndex:indexPath.row];
    self.residentEvaluated = [self.residentNames objectAtIndex:indexPath.row];
    [self.residentsToEvaluate removeObjectAtIndex:indexPath.row];
    [self.residentNames removeObjectAtIndex:indexPath.row];
    NSLog(@"selected cell: %i, %@", (int)indexPath.row, self.currentResidentName);    [self performSegueWithIdentifier:@"segueToEval" sender:self];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    NSLog(@"prepare for segue: %@ for %@", segue.identifier, self.currentResidentName);
    if ([[segue identifier] isEqualToString:@"segueToEval"]){
        
        QuestionViewController *evalForm = segue.destinationViewController;
        evalForm.residentsToEvaluate = [[NSMutableArray alloc] initWithArray:self.residentsToEvaluate];
        evalForm.currentResidentName = [[NSString alloc] initWithString:self.currentResidentName];
        evalForm.residentEvaluated = [[NSString alloc] initWithString:self.residentEvaluated];
        evalForm.residentNames = [[NSMutableArray alloc] initWithArray:self.residentNames];
    }
    
}
    

@end
