//
//  TabBarController.m
//  ArticlesProject
//
//  Created by Dan Toderici on 21/08/15.
//  Copyright (c) 2015 Dan Toderici. All rights reserved.
//

#import "TabBarController.h"
#import "UsersOrArticlesTableViewController.h"
#import "ProfileViewController.h"
#import "Store.h"
#import "User.h"

@interface TabBarController()

@property (nonatomic) UsersOrArticlesTableViewController *usersOrArticlesViewController;
@property (nonatomic) ProfileViewController *profileViewController;

@end

@implementation TabBarController

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    Store *store = [Store defaultStore];
    User *loggedInUser = [store loggedInUser];
    if ( [loggedInUser.isAdmin boolValue])
    {
        [self.tabBar.items[0] setTitle:@"User"];
        
    }
    else
    {
        [self.tabBar.items[0] setTitle:@"Articles"];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
 }

@end
