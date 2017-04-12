//
//  LogInViewController.m
//  ArticlesProject
//
//  Created by Dan Toderici on 18/08/15.
//  Copyright (c) 2015 Dan Toderici. All rights reserved.
//

#import "LogInViewController.h"
#import "Store.h"
#import "User.h"
#import "TabBarController.h"
#import "APUser.h"
@interface LogInViewController () <UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UITextField *usernameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (nonatomic) TabBarController *tabBarController;

@end

@implementation LogInViewController
-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.usernameTextField.text = nil;
    self.passwordTextField.text = nil;
    self.usernameTextField.placeholder = @"Email";
    self.passwordTextField.placeholder = @"Password";
    self.passwordTextField.secureTextEntry = YES;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (IBAction)didTapLogInButton:(id)sender{
    Store *store = [Store defaultStore];
    NSArray *allUsers= [store fetchAllObjectsofClass:[User class]];
    User* existingUser;
    BOOL flag=false;
    for (int i = 0 ;i < allUsers.count ;i++ )
    {
        existingUser = [allUsers objectAtIndex:i];
        //NSLog(@"%@",existingUser);
        if( [existingUser.email isEqualToString:self.usernameTextField.text] && [existingUser.password isEqualToString:self.passwordTextField.text] )
        {
            //NSLog(@"Okay");
            flag = true;
            break;
        }
        else
        {
            //NSLog(@"Try Again");
            
        }
    }
    if(!flag)
    {
        [self shakeView:self.usernameTextField];
        self.usernameTextField.text = nil;
        self.usernameTextField.placeholder =@"Email";
        [self shakeView:self.passwordTextField];
        self.passwordTextField.text = nil;
        self.passwordTextField.placeholder =@"Password";
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                        message:@"Email or Password is invalid"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];

    }
    else
    {
        [store setLoggedInUser:existingUser];
        
        [self performSegueWithIdentifier:@"logInToTabBarSegue" sender:nil];
        
        
    }
}

- (void)shakeView:(UIView*)view
{
    CGRect r = view.frame;
    int x_ = r.origin.x;
    
    r.origin.x = r.origin.x - r.origin.x * 0.1;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:.1f];
    [UIView setAnimationRepeatCount:5];
    [UIView setAnimationRepeatAutoreverses:NO];
    [view setFrame:r];
    
    r.origin.x = x_;
    [view setFrame:r];
    
    [UIView commitAnimations];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

#pragma mark - UIAlertDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //NSLog(@"%@",[alertView buttonTitleAtIndex:buttonIndex]);
}


@end
