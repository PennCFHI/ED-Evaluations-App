//
//  QuestionViewController.h
//  test
//
//  Created by Nadir Bilici on 10/29/15.
//  Copyright © 2015 Nadir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Globals.h"
#import "ResidentListTableViewController.h"

@interface QuestionViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *competencyName;
@property (weak, nonatomic) IBOutlet UISlider *MilestoneSlider;
@property (weak, nonatomic) IBOutlet UITextView *MilestoneDescription;
@property (weak, nonatomic) IBOutlet UIButton *previousButton;
@property (weak, nonatomic) IBOutlet UIButton *MilestoneNextButton;

@property (nonatomic) int competencyIndex;
@property (nonatomic) int numberMilestonesCompleted;
@property (weak, nonatomic) IBOutlet UITextField *writtenEvaluation;

@property (nonatomic) NSMutableArray *milestoneEvaluations;
@property (strong, nonatomic) NSMutableArray *currentResidentArray;

@property (strong, nonatomic) NSMutableArray *residentsToEvaluate;
@property (strong, nonatomic) NSString *currentResidentName;
@property (strong, nonatomic) NSString *shiftDate;

-(IBAction)changed:(id)sender;
-(int)roundSliderValue:(float)x;

@end
