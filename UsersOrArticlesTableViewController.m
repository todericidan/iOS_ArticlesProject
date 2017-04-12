//
//  UsersOrArticlesTableViewController.m
//  ArticlesProject
//
//  Created by Dan Toderici on 24/08/15.
//  Copyright (c) 2015 Dan Toderici. All rights reserved.
//

#import "UsersOrArticlesTableViewController.h"
#import "Store.h"
#import "User.h"
#import "UserDetailsViewController.h"
#import "Article.h"

@interface UsersOrArticlesTableViewController()<NSURLSessionDelegate>

@property (nonatomic) NSMutableArray *allUsers;
@property (nonatomic) NSMutableArray *allArticles;
@property (nonatomic) User *selectedUser;
@property (nonatomic) Article *selectedArticle;
@property (nonatomic) BOOL isViewForAdmin;
@end

static NSString* cellIdentifier=@"adaptiveCell";
@implementation UsersOrArticlesTableViewController

#pragma mark - Life Cycle

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.isViewForAdmin =[[[[Store defaultStore] loggedInUser] isAdmin] boolValue];
    if(self.isViewForAdmin)
    {
        
        self.title = @"Users";
    }
    else
    {
        self.title = @"Articles";
    }
    Store *store = [Store defaultStore];
    self.allUsers = [store fetchAllObjectsofClass:[User class]];
    User *user;
    for(int i = 0; i < self.allUsers.count ;i++)
    {
        user = [self.allUsers objectAtIndex:i];
        if([user.isAdmin boolValue])
        {
            [self.allUsers removeObjectAtIndex:i];
            i--;
        }
    }
    
    self.allArticles = [store fetchAllObjectsofClass:[Article class]];
    [self.tableView reloadData];
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

#pragma mark - TableView

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(self.isViewForAdmin)
    {
        return self.allUsers.count;
    }
    else
    {
        return self.allArticles.count;
    }
    
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(self.isViewForAdmin)
    {
        return 44;
    }
    else
    {
        return 80;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
    
    
    if(!cell)
    {
        cell  = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        
        
        
    }
    if(self.isViewForAdmin)
    {
        cell  = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        User *user =[self.allUsers objectAtIndex:indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text =[NSString stringWithFormat:@"%@ %@",user.firstName,user.lastName];
        cell.textLabel.textColor = [UIColor blackColor];
        if([user.requestedCredit floatValue]>0)
        {
            cell.detailTextLabel.text =[NSString stringWithFormat:@"(request %@ lei)",user.requestedCredit];
            cell.detailTextLabel.textColor = [UIColor blueColor];
        }
        
    }
    else
    {
        cell  = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        Article *article = [self.allArticles objectAtIndex:indexPath.row];
        NSString *articleTitle = [article.title stringByReplacingOccurrencesOfString:@"-" withString:@" "];
        articleTitle = [articleTitle capitalizedString];
        cell.textLabel.text = articleTitle;
        cell.textLabel.adjustsFontSizeToFitWidth = YES;
        cell.textLabel.textColor = [UIColor blueColor];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:10.0];
        
        
        NSString *articleDetails = article.shortDescription;
        articleDetails =[ self stringByStrippingHTML:articleDetails];
        cell.detailTextLabel.text = articleDetails;
        cell.detailTextLabel.font = [UIFont fontWithName:@"Helvetica" size:10];
        cell.detailTextLabel.numberOfLines = 2;
        NSURL *url = [NSURL URLWithString:article.imageURl];
        
        
        // Create a download task.
        NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url
                                                                 completionHandler:^(NSData *data,
                                                                                     NSURLResponse *response,
                                                                                     NSError *error)
                                      {
                                          
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              UIImage *image = [[UIImage alloc] initWithData:data];
                                              cell.imageView.image = image;
                                              [cell setNeedsLayout];
                                              
                                          });
                                      }];
        // Start the task.
        [task resume];
        
        // [self.tableView reloadData];
        
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.isViewForAdmin)
    {
        self.selectedUser = [self.allUsers objectAtIndex:indexPath.row];
        
        [[Store defaultStore]setSelectedUser:self.selectedUser];//de proba
        [self performSegueWithIdentifier:@"userDetails" sender:nil];
    }
    else
    {
        User* user = [[Store defaultStore]loggedInUser];
        if([user.credit floatValue] >= 7.5)
        {
            Store *store= [Store defaultStore];
            self.selectedArticle = [self.allArticles objectAtIndex:indexPath.row];
            [store setSelectedArticle:self.selectedArticle];//de proba
            user.credit =@([user.credit floatValue]-7.5);
            [store updateObject:user];
            [store save];
            [self performSegueWithIdentifier:@"articleDetails" sender:nil];
            
        }
        else
        {
            NSLog(@"Not enough credit!");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:@"Insufficient funds!"
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"Request 7.5 lei credit", @"Request 15 lei credit",nil];
            [alert show];
            
        }
    }
}

#pragma mark - Private
-(void) requestSum:(float)sum
{
    Store *store = [Store defaultStore];
    User *user= [store loggedInUser];
    user.requestedCredit= @([user.requestedCredit integerValue] +sum);
    [store updateObject:user];
    [store save];
    
}

-(NSString *) stringByStrippingHTML:(NSString*) string {
    NSRange r;
    NSString *s = [string copy] ;
    while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    return s;
}

#pragma mark - UIAlertDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // NSLog(@"%@",[alertView buttonTitleAtIndex:buttonIndex]);
    if([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Request 7.5 lei credit"])
    {
        [self requestSum:7.5];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"Request was sent!"
                                                       delegate:self
                                              cancelButtonTitle:@"Okay"
                                              otherButtonTitles:nil];
        [alert show];
    }
    if([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Request 15 lei credit"])
    {
        [self requestSum:15];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"Request was sent!"
                                                       delegate:self
                                              cancelButtonTitle:@"Okay"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
}


@end
