//
//  ResidentListTableViewController.h
//  EmergencyEvals
//
//  Created by David Rub on 11/7/15.
//  Copyright © 2015 poloclub. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResidentListTableViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray *residentQRList;
@property (strong, nonatomic) NSString *shiftDate;

@end
