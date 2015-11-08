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
    self.currentResidentArray = [[NSMutableArray alloc] init];
    self.writtenEvaluation.delegate = self;
    self.MilestoneSlider.continuous = YES;
    self.writtenEvaluation.hidden = YES;
    self.submitButton.hidden = YES;
    self.numberMilestonesCompleted = 0;
    self.competencyIndex = 0;
    self.competencyName.numberOfLines = 0;
    self.competencyName.lineBreakMode = NSLineBreakByWordWrapping;
    [self.competencyName sizeToFit];
    [self.competencyName setText:Competencies[self.competencyIndex][0]];
    [self.MilestoneDescription setText:Competencies[self.competencyIndex][1]];
    
    self.milestoneEvaluations = [[NSMutableArray alloc] init];
    for (int i=0; i<11; i++){
        [self.milestoneEvaluations addObject:([NSNumber numberWithInt:1]) ];
    }
    
    NSLog (@"competencyIndex %i is %@", self.competencyIndex, Competencies[self.competencyIndex][0]);
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

-(int)roundSliderValue:(float)x {
    if (x < 2.0) {
        return 1;
    }
    else if (x < 3.0) {
        return 2;
    }
    else if (x < 4.0) {
        return 3;
    }
    else if (x < 5.0) {
        return 4;
    }
    else if (x < 6.0) {
        return 5;
    }
    else if (x < 7.0) {
        return 6;
    }
    else if (x < 8.0) {
        return 7;
    }
    else if (x < 9.0) {
        return 8;
    }
    else if (x < 10.0){
        return 9;
    }
    else if (x < 11.0){
        return 10;
    }
    else {
        return 11;
    }
}



- (IBAction)changed:(UISlider *)sender {
    
    //round slider value and change milestone text
    [self.MilestoneSlider setValue:[self roundSliderValue:self.MilestoneSlider.value] animated:NO];
    [self.MilestoneDescription setText: Competencies[self.competencyIndex][ (int)self.MilestoneSlider.value] ];
    
    NSNumber *milestoneValue = [NSNumber numberWithInt:((int)self.MilestoneSlider.value)];
    [self.milestoneEvaluations replaceObjectAtIndex:(self.competencyIndex) withObject:milestoneValue];
    
    //NSLog(@"%@", Competencies[0]);
    //NSLog(@"milestoneslider value is %f", self.MilestoneSlider.value);
    //NSLog(@"currentComp %i", self.competencyIndex);
    
}

- (IBAction)nextMilestone:(id)sender {
    //NSLog(@"Milestone Slider Value %f", self.MilestoneSlider.value);
    //NSLog(@"numCompleted before: %i", self.numberMilestonesCompleted);
    //NSLog(@"milestoneEvals %@", self.milestoneEvaluations);
    //record evaluation number in array
    NSLog(@"self.competencyIndex %i", self.competencyIndex);
    
    //11 slider competencies, 12th competency is text
    
    self.numberMilestonesCompleted ++;
    
    if (self.numberMilestonesCompleted == 12){
        //DONE!
        //take written value and add it into end of array. then, evaluation is finished
        NSString *writtenValue = [NSString stringWithString:(self.writtenEvaluation.text)];
        [self.milestoneEvaluations addObject:writtenValue];
        [self.competencyName setText:(@"Evaluations Complete. Thank you!")];
        self.writtenEvaluation.hidden = YES;
        
        NSLog(@"milestoneEvals %@", self.milestoneEvaluations);
        
        //use this array for PFObject
        self.currentResidentArray = self.milestoneEvaluations;
        [self.currentResidentArray addObject:self.currentResidentName];
        [self.currentResidentArray addObject:self.shiftDate];
        
        //hide next button and segue to finished screen
        [self performSegueWithIdentifier:@"evalSubmitted" sender:self];

        
    }
    else if (self.numberMilestonesCompleted == 11){
        //prepare for written evaluation
        [self.writtenEvaluation becomeFirstResponder];
        self.MilestoneDescription.hidden = YES;
        self.MilestoneSlider.hidden = YES;
        self.writtenEvaluation.hidden = NO;
        [self.competencyName setText:Competencies[11][0]];
        self.competencyIndex++;
        self.MilestoneNextButton.hidden = YES;
        self.submitButton.hidden = NO;

    }
    
    else if (self.numberMilestonesCompleted <11){
        
        //loop to next competency if all 11 not yet completed
        //reset label and description values for next competency
        self.competencyIndex++;
        
        NSLog(@"array competency index %i", self.competencyIndex);
        
        [self.competencyName setText:Competencies[self.competencyIndex][0]];
        
        //if user already set value for this competency, slider set to previously entered value; otherwise set to 1
        //if under 10 completed, set values
        if (((int)self.milestoneEvaluations[self.competencyIndex] != 1)){
            [self.MilestoneSlider setValue:[self.milestoneEvaluations[self.competencyIndex] floatValue]];
        }
        else [self.MilestoneSlider setValue:1];
        
        //reset milestone description
        [self.MilestoneDescription setText:Competencies[self.competencyIndex][(int)self.MilestoneSlider.value]];
        
    }
    
    NSLog(@"milestoneEvals %@", self.milestoneEvaluations);
    NSLog (@"number milestones completed %i", self.numberMilestonesCompleted);
    NSLog (@"competencyIndex %i is %@", self.competencyIndex, Competencies[self.competencyIndex][0]);
}


- (IBAction)pressBack:(id)sender {
    
    if (self.numberMilestonesCompleted == 0){
        //go back to previous screen
    }
    else{
        if (self.numberMilestonesCompleted == 12){
            //remove textbox
            self.MilestoneDescription.hidden = NO;
            self.MilestoneSlider.hidden = NO;
            self.writtenEvaluation.hidden = YES;
            self.submitButton.hidden = YES;
            self.MilestoneNextButton.hidden = NO;
            [self.milestoneEvaluations removeLastObject];
            //self.numberMilestonesCompleted --;
            
        }
        else if (self.numberMilestonesCompleted == 11){
            self.MilestoneDescription.hidden = NO;
            self.MilestoneSlider.hidden = NO;
            self.writtenEvaluation.hidden = YES;
        }
        
        
        //restore previous values
        self.competencyIndex --;
        self.numberMilestonesCompleted --;
        float prevMilestoneEval = [self.milestoneEvaluations[self.competencyIndex] floatValue];
        [self.MilestoneSlider setValue:prevMilestoneEval];
        [self.competencyName setText:Competencies[self.competencyIndex][0]];
        [self.MilestoneDescription setText:Competencies[self.competencyIndex][(int)prevMilestoneEval]];
        
        NSLog (@"number milestones completed %i", self.numberMilestonesCompleted);
        NSLog (@"competencyIndex %i is %@", self.competencyIndex, Competencies[self.competencyIndex][0]);
        
    }
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //tap off keyboard
    [[self view] endEditing:TRUE];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([[segue identifier]  isEqualToString:@"backToResidentList"]){
        [self.residentsToEvaluate addObject:self.currentResidentName];
        ResidentListTableViewController *residentTable = [segue destinationViewController];
        residentTable.residentQRList = [[NSMutableArray alloc] initWithArray:self.residentsToEvaluate];
        residentTable.shiftDate = [[NSString alloc] initWithString:self.shiftDate];
    }
    
    if([[segue identifier] isEqualToString:@"evalSubmitted"]){
        
        NSLog(@"eval submitted. %i residents left", (int)self.residentsToEvaluate.count);
        if (self.residentsToEvaluate.count != 0){
            // Loop to list of residents until all evaluated
            ResidentListTableViewController *residentTable = [segue destinationViewController];
            residentTable.residentQRList = [[NSMutableArray alloc] initWithArray:self.residentsToEvaluate];
            residentTable.shiftDate = [[NSString alloc] initWithString:self.shiftDate];
            
            // use self.currentResidentArray for PFObject
        }
        else{
            // Evals complete. Restart app.
            UIViewController *viewController = [segue destinationViewController];
            
        }
    }
}



@end
