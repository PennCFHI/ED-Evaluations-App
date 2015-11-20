//
//  ResidentListTableViewController.h
//  EmergencyEvals
//
//  Created by David Rub on 11/7/15.
//  Copyright © 2015 poloclub. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionViewController.h"
#import <Parse/Parse.h>

@interface ResidentListTableViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray *residentQRList;
@property (strong,nonatomic)  NSMutableArray *residentNames;
@property (strong, nonatomic) NSString *shiftDate;
@property (strong, nonatomic) NSMutableArray *residentsToEvaluate;
@property (strong, nonatomic) IBOutlet UITableView *residentTable;
@property (strong, nonatomic) NSString *residentEvaluated;
@property (nonatomic) BOOL *hasEvaluatedSegue;

@end
