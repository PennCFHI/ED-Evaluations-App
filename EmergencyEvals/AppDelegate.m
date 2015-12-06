//
//  AppDelegate.m
//  EmergencyEvals
//
//  Created by David Rub on 10/24/15.
//  Copyright (c) 2015 poloclub. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import "Globals.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    //set navigation controller
    
    
    // Initialize Parse.
    [Parse setApplicationId:@"N7kQs8tlZwXtAvI8oUll4TWyfp4CVeZIj9YAylpU"
                  clientKey:@"6JR2KD0JqCDWWexcK5oBoyP472mB0TF5qwrMTC18"];
    
    // [Optional] Track statistics around application opens.
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    
    //Initialize Arrays
    CompetencyOne =
    [ NSArray arrayWithObjects:
     //0 - name of competency
     @"Emergency Stabilization",
     @"Unable to assess",
     @"0: Has Not Achieved",
     @"1: Recognizes Abnormal Vital Signs",
     @"2: Recognizes when a patient is unstable, requiring immediate intervention",
     @"3: Reassesses patient after a stabilization intervention. Prioritizes critical stabilization actions",
     @"4: Recognizes when resucitation efforts are ineffective",
     @"5: Develops policies and procedures for the management of critically ill patients",
     //11
     nil
     ];
    
    CompetencyTwo =
    [ NSArray arrayWithObjects:
     @"Performance of Focused History and Physical Exam",
     @"Unable to assess",
     @"Has not achieved",
     @"1: Performs and communicates a reliable H&P",
     @"2: Performs and communicates a chief complaint focused H&P",
     @"3: Prioritizes essential components of the H&P in a time critical situation",
     @"4: Synthesizes ancillary data (past records, family) routinely when gathering the H&P",
     @"5: Identifies obscure, occult, or rare conditions based soley on H&P",
     nil];
    
    CompetencyThree =
    [ NSArray arrayWithObjects:
     @"Diagnostic Studies",
     @"Unable to assess",
     @"Has not achieved",
     @"1: Determines when diagnostic studies are needed",
     @"2: Prioritized essential testing",
     @"3: Interprets diagnostic studies accurately and seeks assistance when needed",
     @"4: Uses diagnostic testing based on pretest probability",
     @"5: Discriminates between subtle and/or conflicting diagnostic results in the context of the patient presentation",
     nil];
    
    CompetencyFour =
    [ NSArray arrayWithObjects:
     @"Diagnosis",
     @"Unable to assess",
     @"Has not achieved",
     @"1: Able to contruct a 'most likely' DDX",
     @"2: Able to construct a 'most deadly' DDX",
     @"3: Revises the DDX in response to patients course",
     @"4: Constructs a weighted DDX using all available data and develops a management strategy",
     @"5: Uses clinical experience to identify outliers or unusual presentations",
     nil];
    
    CompetencyFive =
    [ NSArray arrayWithObjects:
     @"Pharmacotherapy",
     @"Unable to assess",
     @"Has not achieved",
     @"1: Knows classifications and mechanisms of action of commonly used medications",
     @"2: Considers adverse effects of medications",
     @"3: Considers and recognizes potential drug-drug interactions \nConsiders medication options and selects an appropriate agent",
     @"4: Selects appropriate medications based upon age, weight, and co-morbidities as well as clinical guidelines and financial considerations",
     @"5: Participates in developing institutional policies on pharmacotherapy",
     nil];
    
    CompetencySix =
    [ NSArray arrayWithObjects:
     @"Observation and Reassessment",
     @"Unable to assess",
     @"Has not achieved",
     @"1: Recognizes the need for patient reevaluation",
     @"2: Monitors that necessary therapeutic interventions are performed",
     @"3: Identifies which patients will require ED reassessment \nReevaluates the efficacy of treatments when indicated",
     @"4: Complies and documents with regulatory requirements for disposition of patients to observation and admission",
     @"5: Develops protocols to avoid potential complications of therapies",
     nil];
    
    
    CompetencySeven =
    [ NSArray arrayWithObjects:
     @"Disposition",
     @"Unable to assess",
     @"Has not achieved",
     @"1: Describes basic resources available in ED",
     @"2: Formulates specific follow-up plan for common ED complaints",
     @"3: Makes correct disposition decisions (home vs admit vs ICU)",
     @"4: Routinely discusses discharge plans with patients and their family",
     @"5: Develops institutional systems to enhance safe patient dispositions",
     nil];
    
    CompetencyEight =
    [ NSArray arrayWithObjects:
     @"Multi-tasking",
     @"Unable to assess",
     @"Has not achieved",
     @"1: Manages a single patient effectively",
     @"2: Effectively task switches between two patients",
     @"3: Effectively task switches among multiple patients",
     @"4: Effectively task switches among patient care, trauma assessments, medical command, and senior admin duties",
     @"5: Effectively task switches in a surge or disaster situation",
     nil];
    
    CompetencyNine =
    [ NSArray arrayWithObjects:
     @"General Approach to Procedures",
     @"Unable to assess",
     @"Has not achieved",
     @"1: Understands the importance of universal precautions",
     @"2: Knows the indications, complications, anatomic landmarks, equipment, and techniques to perform common ED procedures",
     @"3: Determines alternative strategy if initial attempts to perform a procedure are unsuccessful",
     @"4: Performs procedure on patients with challenging features (poor landmarks, extremes of age, co-morbidities)",
     @"5: Teaches procedural competency and corrects mistakes",
     nil];
    
    CompetencyTen =
    [ NSArray arrayWithObjects:
     @"Anesthesia and Acute Pain Management",
     @"Unable to assess",
     @"Has not achieved",
     @"1: Uses local anesthetics appropriate (proper dosing and technique)",
     @"2: Knows the appropriate indications, dosing, and complications of analgesics and sedative medicaitons",
     @"3: Routinely performs presedation assessment and obtains informed consent \nEnsures appropriate monitoring during procedural sedation",
     @"4: Titrates procedural sedation medications to ensure adequate sedation while minimizing recovery time",
     @"5; Develops pain management protocols and care plans",
     nil];
    
    CompetencyEleven =
    [ NSArray arrayWithObjects:
     @"Team Management",
     @"Unable to assess",
     @"Has not achieved",
     @"1: Participates as a member of a patient care team",
     @"2: Communicates effectively with faculty, nurses and other ED staff",
     @"3: Communicates effectively when performing Doc to Doc, sign out rounds, and with consultants",
     @"4: Uses flexible communication strategies when interacting with difficult consultants",
     @"5: Participates in and leads interdepartmental patient-centered care groups",
     nil];
    
    CompetencyTwelve =
    [ NSArray arrayWithObjects:
     @"Describe any feedback you discussed with the resident",
     nil];
    
    Competencies =
    [ NSArray arrayWithObjects:
     CompetencyOne,
     CompetencyTwo,
     CompetencyThree,
     CompetencyFour,
     CompetencyFive,
     CompetencySix,
     CompetencySeven,
     CompetencyEight,
     CompetencyNine,
     CompetencyTen,
     CompetencyEleven,
     CompetencyTwelve,
     nil];
    
    // Override point for customization after application launch.
    return YES;
    
    
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



@end
