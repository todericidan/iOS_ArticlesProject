//
//  ProfileViewController.m
//  ArticlesProject
//
//  Created by Dan Toderici on 21/08/15.
//  Copyright (c) 2015 Dan Toderici. All rights reserved.
//

#import "ProfileViewController.h"
#import "User.h"
#import "Store.h"
#import "Transaction.h"
#import "APUser.h"

@interface ProfileViewController()<UIAlertViewDelegate>


@property (strong, nonatomic) IBOutlet UILabel *userLabel;
@property (strong, nonatomic) IBOutlet UILabel *creditLabel;
@property (strong, nonatomic) IBOutlet UILabel *ageLabel;
@property (strong, nonatomic) IBOutlet UILabel *emailLabel;
@property (strong, nonatomic) IBOutlet UILabel *occupationLabel;
@property (strong, nonatomic) IBOutlet UIButton *logOutButton;
@property (strong, nonatomic) IBOutlet UIButton *request15LeiButton;
@property (strong, nonatomic) IBOutlet UIButton *request7LeiButton;

@end

@implementation ProfileViewController

#pragma mark - Life Cycle

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setUpAdaptiveViewBasedOnUserRole];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

#pragma mark - Private

- (void) setUpAdaptiveViewBasedOnUserRole
{
    Store *store = [Store defaultStore];
    User *userDetails = [store loggedInUser];
    
    self.userLabel.text = [NSString stringWithFormat:@"%@ %@",userDetails.firstName,userDetails.lastName];
    self.creditLabel.text =[NSString stringWithFormat:@"%@: %@ %@",@"Credit",userDetails.credit,@"lei"];
    if([userDetails.isAdmin  isEqual: @1])
    {
        self.creditLabel.alpha = 0;
        self.request15LeiButton.alpha = 0;
        self.request7LeiButton.alpha = 0;
    }
    else
    {
        self.request7LeiButton.layer.borderWidth = 0.5f;
        self.request7LeiButton.layer.borderColor = [UIColor blackColor].CGColor ;
        self.request15LeiButton.layer.borderWidth = 0.5f;
        self.request15LeiButton.layer.borderColor = [UIColor blackColor].CGColor ;
        
    }
    self.emailLabel.text = [NSString stringWithFormat:@"%@: %@",@"Email",userDetails.email];
    self.ageLabel.text = [NSString stringWithFormat:@"%@: %@",@"Age",userDetails.age];
    self.occupationLabel.text = [NSString stringWithFormat:@"%@: %@",@"Occupation",userDetails.occupation];
    self.logOutButton.layer.borderWidth = 0.5f;
    self.logOutButton.layer.borderColor = [UIColor blackColor].CGColor ;
}

# pragma mark - IBAction
- (IBAction)didTappedRequest15LeiButton:(id)sender
{
    [self requestSum:(float)15];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Request was sent!"
                                                    message:nil
                                                   delegate:self
                                          cancelButtonTitle:@"Okay"
                                          otherButtonTitles: nil];
    [alert show];
}


- (IBAction)didTappedRequest7LeiButton:(id)sender
{
    [self requestSum:(float)7.5];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Request was sent!"
                                                    message:nil
                                                   delegate:self
                                          cancelButtonTitle:@"Okay"
                                          otherButtonTitles: nil];
    [alert show];
}


-(void) requestSum:(float)sum
{
    Store *store = [Store defaultStore];
    User *user= [store loggedInUser];
    user.requestedCredit= @([user.requestedCredit integerValue] +sum);
    [store updateObject:user];
    [store save];
    
}
- (IBAction)didTappedLogOutButton:(id)sender
{
    Store *store = [Store defaultStore];
    
    [store setLoggedInUser:nil];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
