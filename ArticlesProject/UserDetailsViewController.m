//
//  UserDetailsViewController.m
//  ArticlesProject
//
//  Created by Dan Toderici on 24/08/15.
//  Copyright (c) 2015 Dan Toderici. All rights reserved.
//

#import "UserDetailsViewController.h"
#import "User.h"
#import "UsersOrArticlesTableViewController.h"
#import "Store.h"

@interface UserDetailsViewController ()<UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *userFullNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *creditLabel;
@property (strong, nonatomic) IBOutlet UILabel *emailLabel;
@property (strong, nonatomic) IBOutlet UILabel *ageLabel;
@property (strong, nonatomic) IBOutlet UILabel *occupationLabel;
@property (strong, nonatomic) IBOutlet UILabel *requestedSumLabel;
@property (strong, nonatomic) IBOutlet UIButton *approveRequestButton;
@property (nonatomic) User *user;


@end

@implementation UserDetailsViewController
#pragma mark - Life Cycle

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.user = [[Store defaultStore]selectedUser];//de proba
    
    [self setUpView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

#pragma mark - Private

- (void) setUpView
{
    self.userFullNameLabel.text = [NSString stringWithFormat:@"%@ %@",self.user.firstName,self.user.lastName];
    self.creditLabel.text = [NSString stringWithFormat:@"Credit: %@ lei",self.user.credit];
    self.emailLabel.text = [NSString stringWithFormat:@"Email: %@",self.user.email];
    self.ageLabel.text = [NSString stringWithFormat:@"Age: %@",self.user.age];
    self.occupationLabel.text = [NSString stringWithFormat:@"Occupation: %@",self.user.occupation];
    self.requestedSumLabel.text = [NSString stringWithFormat:@"%@ requests %@ lei",self.user.firstName,self.user.requestedCredit];
    self.approveRequestButton.layer.borderWidth = 0.5f;
    self.approveRequestButton.layer.borderColor = [UIColor blackColor].CGColor ;
    if([self.user.requestedCredit integerValue] == 0)
    {
        self.requestedSumLabel.alpha = 0;
        self.approveRequestButton.alpha = 0;
    }
    
}

# pragma mark - IBAction
- (IBAction)didTappedApproveRequestButton:(id)sender
{
    NSLog(@"Not enough credit!");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please confirm"
                                                    message:[NSString stringWithFormat:@"%@'s account will be credited with %@ lei",self.user.firstName,self.user.requestedCredit]
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"Ok", nil];
    [alert show];


    
}


#pragma mark - UIAlertDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
   // NSLog(@"%@",[alertView buttonTitleAtIndex:buttonIndex]);
    if([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Ok"])
    {
        Store *store = [Store defaultStore];
        self.user.credit = @([self.user.credit floatValue] +[self.user.requestedCredit floatValue]);
        self.user.requestedCredit = @0;
        [store updateObject:self.user];
        [store save];
//        self.requestedSumLabel.text = [NSString stringWithFormat:@"%@ requests %@ lei",self.user.firstName,self.user.requestedCredit];
//        self.creditLabel.text = [NSString stringWithFormat:@"Credit: %@ lei",self.user.credit];
        self.requestedSumLabel.alpha = 0;
        self.approveRequestButton.alpha = 0;
    }
}

@end
