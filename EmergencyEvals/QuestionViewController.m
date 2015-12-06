//
//  QuestionViewController.m
//  test
//
//  Created by Nadir Bilici on 10/29/15.
//  Copyright © 2015 Nadir. All rights reserved.
//

#import "QuestionViewController.h"

@interface QuestionViewController ()


@end

@implementation QuestionViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"loaded QuestionViewController and currently evaluating %@", self.currentResidentName);

    // Set up counters and variables
    self.currentResidentArray = [[NSMutableArray alloc] init];
    self.numberMilestonesCompleted = 0;
    self.competencyIndex = 0;
    self.milestoneValue = 3;
    [self.milestoneNumberLabel setText:[NSString stringWithFormat:@"%i", (int)self.milestoneValue]];
    
    // Set up UI
    [self.writtenEvaluation sizeToFit];
    self.writtenEvaluation.delegate = self;
    self.writtenEvaluation.hidden = YES;
    self.previousButton.hidden = YES;
    self.competencyName.numberOfLines = 0;
    self.competencyName.lineBreakMode = NSLineBreakByWordWrapping;
    [self.competencyName sizeToFit];
    [self.competencyName setText:Competencies[self.competencyIndex][0]];
    [self.MilestoneDescription setText:Competencies[self.competencyIndex][1]];
    [self.progressLabel setText:[NSString stringWithFormat:@"%i/12", (self.numberMilestonesCompleted+1)]];
    [self.residentNameLabel setText:[NSString stringWithFormat:@"Currently Evaluating %@", self.residentEvaluated]];
    
    // Define array with default values of 1: "Unable to Assess"
    self.milestoneEvaluations = [[NSMutableArray alloc] init];
    for (int i=0; i<11; i++){
        [self.milestoneEvaluations addObject:([NSNumber numberWithInt:3]) ];
    }
    
    
    //hide back button
    [self.navigationItem setHidesBackButton:YES];
    
    NSLog (@"competencyIndex %i is %@", self.competencyIndex, Competencies[self.competencyIndex][0]);
    NSLog (@"milestone value is %i", self.milestoneValue);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)milestoneDecrement:(id)sender {
    // Decrement milestone number and update array with new milestone value
    if((int)self.milestoneValue>0){
        self.milestoneValue -= 1;
    }
    [self.milestoneNumberLabel setText:[NSString stringWithFormat:@"%i", (int)self.milestoneValue]];
    NSNumber *tempMilestoneValue = [NSNumber numberWithInt:(int)self.milestoneValue];
    [self.milestoneEvaluations replaceObjectAtIndex:(self.competencyIndex) withObject:tempMilestoneValue];
    [self.MilestoneDescription setText:Competencies[self.competencyIndex][(int)self.milestoneValue]];
    NSLog(@"Decremented Milestone to %i", self.milestoneValue);
}

- (IBAction)milestoneIncrement:(id)sender {
    // Increment milestone number and update array with new milestone value
    if((int)self.milestoneValue<5){
        self.milestoneValue += 1;
    }
    [self.milestoneNumberLabel setText:[NSString stringWithFormat:@"%i", (int)self.milestoneValue]];
    NSNumber *tempMilestoneValue = [NSNumber numberWithInt:(int)self.milestoneValue];
    [self.milestoneEvaluations replaceObjectAtIndex:(self.competencyIndex) withObject:tempMilestoneValue];
    [self.MilestoneDescription setText:Competencies[self.competencyIndex][(int)self.milestoneValue]];
    NSLog(@"Incremented Milestone to %i", self.milestoneValue);
}




- (IBAction)nextMilestone:(id)sender {
    //11 slider competencies, 12th competency is text

    NSLog(@"nextmilestone -> self.milestonevalue is %i", self.milestoneValue);
    NSLog(@"milestone evals array %@", self.milestoneEvaluations);
   

    self.previousButton.hidden = NO;
    self.numberMilestonesCompleted ++;
    NSLog(@"next clicked. currently at self.competencyIndex %i. completed %i milestones", self.competencyIndex, self.numberMilestonesCompleted);

    if (self.numberMilestonesCompleted == 12){
        // Done with evaluation form
        // Take written value and add it into end of array. Then, evaluation is finished --> segue
        NSString *writtenValue = [NSString stringWithString:(self.writtenEvaluation.text)];
        [self.milestoneEvaluations addObject:writtenValue];
        self.writtenEvaluation.hidden = YES;
        
        // Final array with name and date added
        self.currentResidentArray = self.milestoneEvaluations;
        [self.currentResidentArray addObject:self.currentResidentName];
        NSLog(@"Final array %@", self.currentResidentArray);
        
        //send array to Parse as PFObject EvaluationData
        PFObject *evaluationData = [PFObject objectWithClassName:@"EvaluationData"];
        evaluationData[@"Attending"] = [[PFUser currentUser] objectForKey:@"PennID"];
        evaluationData[@"Resident"] = self.currentResidentName;
        evaluationData[@"Emergency_Stabilization"] = _currentResidentArray[0];
        evaluationData[@"History_and_Physical"] = _currentResidentArray[1];
        evaluationData[@"Diagnostic_Studies"] = _currentResidentArray[2];
        evaluationData[@"Diagnosis"] =_currentResidentArray[3];
        evaluationData[@"Pharmacotherapy"] =_currentResidentArray[4];
        evaluationData[@"Observation_and_Reassessment"] = _currentResidentArray[5];
        evaluationData[@"Disposition"] = _currentResidentArray[6];
        evaluationData[@"Multitasking"] = _currentResidentArray[7];
        evaluationData[@"General_Approach"] = _currentResidentArray[8];
        evaluationData[@"Anesthesia_AcutePain"] =_currentResidentArray[9];
        evaluationData[@"Team_Management"] = _currentResidentArray[10];
        evaluationData[@"Written_Feedback"] = _currentResidentArray[11];
        [evaluationData saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSLog(@"evaluation has been saved");
            } else {
                NSLog(@"error has occured when trying to save Evaluation Data");
            }
        }];

        
        // If more residents left to evaluate, segue to table
        // Otherwise, segue to main screen
        if (self.residentsToEvaluate.count == 0){
            [self performSegueWithIdentifier:@"segueToMain" sender:self];
        }
        else{
            [self performSegueWithIdentifier:@"backToResidentList" sender:self];
        }

        
    }
    else if (self.numberMilestonesCompleted == 11){
        // Finished with slider competencies
        NSNumber *tempMilestoneValue = [NSNumber numberWithInt:(int)self.milestoneValue];
        [self.milestoneEvaluations replaceObjectAtIndex:(self.competencyIndex) withObject:tempMilestoneValue];
        
        // Rename Next button -> Submit
        //[self.MilestoneNextButton setTitle:@"Submit" forState:UIControlStateNormal];
        //[self.MilestoneNextButton sizeToFit];
        self.MilestoneNextButton.hidden = YES;
        // Prepare for textbox feedback
        [self.writtenEvaluation becomeFirstResponder];
        self.MilestoneDescription.hidden = YES;
        self.milestoneNumberLabel.hidden = YES;
        self.milestoneIncrementButton.hidden = YES;
        self.milestoneDecrementButton.hidden = YES;
        self.writtenEvaluation.hidden = NO;
        [self.competencyName setText:Competencies[11][0]];
        self.competencyIndex++;
        
        UIBarButtonItem *continueButton = [[UIBarButtonItem alloc]
                                           initWithTitle:@"Submit"
                                           style:UIBarButtonItemStyleDone
                                           target:self
                                           action:@selector(nextMilestone:)];
        self.navigationItem.rightBarButtonItem = continueButton;
    }
    
    else if (self.numberMilestonesCompleted <11){
        // All slider competencies not yet completed -> Go to next slider competency

        // Add milestone value to array
        NSNumber *tempMilestoneValue = [NSNumber numberWithInt:(int)self.milestoneValue];
        [self.milestoneEvaluations replaceObjectAtIndex:(self.competencyIndex) withObject:tempMilestoneValue];

        // Reset label value for next competency
        self.competencyIndex++;
        [self.competencyName setText:Competencies[self.competencyIndex][0]];
        
        // Reset milestone value to previously entered value or default value
        self.milestoneValue = [(self.milestoneEvaluations[self.competencyIndex]) intValue];
        
        // Reset milestone description and number label
        [self.milestoneNumberLabel setText:[NSString stringWithFormat:@"%i", (int)self.milestoneValue]];
        [self.MilestoneDescription setText:Competencies[self.competencyIndex][self.milestoneValue]];
        
    }

    [self.progressLabel setText:[NSString stringWithFormat:@"%i/12", (self.numberMilestonesCompleted+1)]];
    
}


- (IBAction)pressBack:(id)sender {
    
    // Add milestone value to array
    if (self.numberMilestonesCompleted<11){
        NSNumber *tempMilestoneValue = [NSNumber numberWithInt:(int)self.milestoneValue];
        [self.milestoneEvaluations replaceObjectAtIndex:(self.competencyIndex) withObject:tempMilestoneValue];
    }
        
    // Not on first competency -> show back button
    self.previousButton.hidden = NO;
    
    // Going from textbox competency -> slider competency
    if (self.numberMilestonesCompleted == 11){
        self.MilestoneDescription.hidden = NO;
        self.milestoneNumberLabel.hidden = NO;
        self.milestoneDecrementButton.hidden = NO;
        self.milestoneIncrementButton.hidden = NO;
        self.writtenEvaluation.hidden = YES;
        self.MilestoneNextButton.hidden = NO;
    }
    
    // Restore previous values of label, description, and slider value
    self.competencyIndex --;
    self.numberMilestonesCompleted --;
    int prevMilestoneEval = [self.milestoneEvaluations[self.competencyIndex] intValue];
    self.milestoneValue = prevMilestoneEval;
    [self.milestoneNumberLabel setText:[NSString stringWithFormat:@"%i", (int)self.milestoneValue]];
    [self.competencyName setText:Competencies[self.competencyIndex][0]];
    [self.MilestoneDescription setText:Competencies[self.competencyIndex][(int)prevMilestoneEval]];
    

    if (self.numberMilestonesCompleted == 0){
        // If evaluating first competency -> hide back button
        self.previousButton.hidden = YES;
    }
    
    [self.progressLabel setText:[NSString stringWithFormat:@"%i/12", (self.numberMilestonesCompleted+1)]];
    
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //tap off keyboard
    [[self view] endEditing:TRUE];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    //return button closes keyboard
    [textField resignFirstResponder];
    return YES;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    NSLog(@"residents left to evaluate: %@", self.residentsToEvaluate);
    
    if([[segue identifier]  isEqualToString:@"segueToMain"]){
        NSLog(@"eval Submitted --> segue to viewController");
        UIViewController *viewController = [segue destinationViewController];
    }
    
    if([[segue identifier] isEqualToString:@"backToResidentList"]){
        NSLog(@"eval Submitted -> segue to ResidentList to evaluate more residents");
        ResidentListTableViewController *residentTable = segue.destinationViewController;
        residentTable.residentQRList = [[NSMutableArray alloc] initWithArray:self.residentsToEvaluate];
        residentTable.residentNames = [[NSMutableArray alloc] initWithArray:self.residentNames];
        residentTable.hasEvaluatedSegue = TRUE;
    }
    
}

@end
