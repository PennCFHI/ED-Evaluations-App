// Log-In View Controller
//  ViewController.m
//  EmergencyEvals
//
//  Created by David Rub on 10/24/15.
//  Copyright (c) 2015 poloclub. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
   /* self.testLabel = [[UILabel alloc] initWithFrame: CGRectMake((self.view.frame.size.width - 200)/2,
                                                                (self.view.frame.size.height * 1/8) + 100,
                                                                200,
                                                                50)];*/
    
    /*if ([PFUser currentUser]) {
        self.testLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Welcome %@!", nil), [[PFUser currentUser] username]];
    } else {
        self.testLabel.text = NSLocalizedString(@"Not logged in", nil);
    }
    
    [self.view addSubview:self.testLabel];*/
    
 
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (![PFUser currentUser]) { // No user logged in
        // Create the log in view controller
        PFLogInViewController *logInViewController = [[PFLogInViewController alloc] init];
        logInViewController.emailAsUsername = TRUE;
        
        
        [logInViewController setDelegate:self]; // Set ourselves as the delegate
        
        // Create the sign up view controller
        PFSignUpViewController *signUpViewController = [[PFSignUpViewController alloc] init];
  
        
        [signUpViewController setFields:PFSignUpFieldsDefault];
        signUpViewController.emailAsUsername = TRUE;
        [signUpViewController setDelegate:self]; // Set ourselves as the delegate
        
        // Assign our sign up controller to be displayed from the login controller
        [logInViewController setSignUpController:signUpViewController];
        
        // Present the log in view controller
        [self presentViewController:logInViewController animated:YES completion:NULL];
    }

    
    
}





/////////////////////////////////////////
////////////////////////////////////////
//////\/\/\/\/\/\/\/\/\//\/\/\/\/\\\\\\\

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //View Size Constants
    int buttonWidth = 200;
    int buttonHeight = 50;
     
    
    //background information
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    
    //keyboard resign
    self.resign= [[UIButton alloc] initWithFrame:CGRectMake(0, 0,
                                                            self.view.frame.size.width,
                                                            self.view.frame.size.height)];
    [self.resign addTarget:self action:@selector(resignKeyboard:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.resign];
    

   /* //Test Object for Parse
    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    testObject[@"foo"] = @"bar";
    [testObject saveInBackground];
  */
    
    //logout button
    self.logOut = [[UIButton alloc] initWithFrame: CGRectMake((self.view.frame.size.width - buttonWidth)/2,
                                                              (self.view.frame.size.height * 3/4),
                                                              buttonWidth,
                                                              buttonHeight)];
    [self.logOut setBackgroundColor:[UIColor blackColor]];
    [self.logOut setTitle:@"Log Out" forState:UIControlStateNormal];
    [self.logOut addTarget:self action:@selector(logOutOfThisApp:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.logOut];
    
    //scanner button
    self.ScanResidentButton = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width - buttonWidth)/2,
                                                                         (self.view.frame.size.height * 2/4),
                                                                         buttonWidth,
                                                                         buttonHeight)];
    [self.ScanResidentButton setBackgroundColor:[UIColor blackColor]];
    [self.ScanResidentButton setTitle:@"Scan Resident" forState:UIControlStateNormal];
    [self.ScanResidentButton addTarget:self action:@selector(launchScanner:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.ScanResidentButton];
    
    //QR Button
    self.showQRCodeButton = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width - buttonWidth)/2,
                                                                         (self.view.frame.size.height * 1/4),
                                                                         buttonWidth,
                                                                         buttonHeight)];
    [self.showQRCodeButton setBackgroundColor:[UIColor blackColor]];
    [self.showQRCodeButton setTitle:@"Show QR Code" forState:UIControlStateNormal];
    [self.showQRCodeButton addTarget:self action:@selector(showQR:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.showQRCodeButton];
    
    [self.navigationItem setHidesBackButton:YES];
    
    
}
////////////////////////////


#pragma mark - PFLogInViewControllerDelegate

// Sent to the delegate to determine whether the log in request should be submitted to the server.
- (BOOL)logInViewController:(PFLogInViewController *)logInController shouldBeginLogInWithUsername:(NSString *)username password:(NSString *)password {
    // Check if both fields are completed
    if (username && password && username.length && password.length) {
        return YES; // Begin login process
    }
    
    [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Missing Information", nil) message:NSLocalizedString(@"Make sure you fill out all of the information!", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil] show];
    return NO; // Interrupt login process
}

// Sent to the delegate when a PFUser is logged in.
- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

// Sent to the delegate when the log in attempt fails.
- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error {
    NSLog(@"Failed to log in...");
}

// Sent to the delegate when the log in screen is dismissed.
- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
    NSLog(@"User dismissed the logInViewController");
}

#pragma mark - PFSignUpViewControllerDelegate

// Sent to the delegate to determine whether the sign up request should be submitted to the server.
- (BOOL)signUpViewController:(PFSignUpViewController *)signUpController shouldBeginSignUp:(NSDictionary *)info {
    BOOL informationComplete = YES;
    
    // loop through all of the submitted data
    for (id key in info) {
        NSString *field = [info objectForKey:key];
        if (!field || !field.length) { // check completion
            informationComplete = NO;
            break;
        }
    }
    
    // Display an alert if a field wasn't completed
    if (!informationComplete) {
        [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Missing Information", nil) message:NSLocalizedString(@"Make sure you fill out all of the information!", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil] show];
    }
    
    return informationComplete;
}

// Sent to the delegate when a PFUser is signed up.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

// Sent to the delegate when the sign up attempt fails.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didFailToSignUpWithError:(NSError *)error {
    NSLog(@"Failed to sign up...");
}

// Sent to the delegate when the sign up screen is dismissed.
- (void)signUpViewControllerDidCancelSignUp:(PFSignUpViewController *)signUpController {
    NSLog(@"User dismissed the signUpViewController");
}

////////////////////////////

-(IBAction)resignKeyboard:(id)sender {
    [self.view endEditing:YES];
}

-(IBAction)logOutOfThisApp:(id)sender{
    NSLog(@"log out button pressed");
    [PFUser logOut];
    // Create the log in view controller
    PFLogInViewController *logInViewController = [[PFLogInViewController alloc] init];
    [logInViewController setDelegate:self]; // Set ourselves as the delegate
    
    // Create the sign up view controller
    PFSignUpViewController *signUpViewController = [[PFSignUpViewController alloc] init];
    [signUpViewController setDelegate:self]; // Set ourselves as the delegate
    
    // Assign our sign up controller to be displayed from the login controller
    [logInViewController setSignUpController:signUpViewController];
    
    // Present the log in view controller
    [self presentViewController:logInViewController animated:YES completion:NULL];

}

-(IBAction)launchScanner:(id)sender{
    NSLog(@"launch Scanner pressed");
    
    [self performSegueWithIdentifier:@"launchScanner" sender:self]; 
    
    
}

-(IBAction)showQR:(id)sender{
    NSLog(@"showQr pressed");
  
    NSString *currentUser = [[PFUser currentUser] username];
    NSLog(@"Current User is: %@", currentUser);
    QRCodeViewController *QRViewController = [[QRCodeViewController alloc] init];
    self.pennID = [[PFUser currentUser] objectForKey:@"additional"];
    NSLog(@"current User %@, with Penn ID: %@", currentUser, self.pennID);
    QRViewController.userID = self.pennID;
    [self presentViewController:QRViewController animated:YES completion:NULL];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([[segue identifier] isEqualToString:@"launchScanner"]){
        
        
        
    }
    
}



@end
