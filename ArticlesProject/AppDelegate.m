//
//  AppDelegate.m
//  ArticlesProject
//
//  Created by Dan Toderici on 18/08/15.
//  Copyright (c) 2015 Dan Toderici. All rights reserved.
//

#import "AppDelegate.h"
#import "User.h"
#import "Transaction.h"
#import "Store.h"
#import "Article.h"

@interface AppDelegate () <NSURLSessionDelegate>

@end

@implementation AppDelegate

#pragma mark- Life Cycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self loadData];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
    
}

#pragma mark - Helpers

- (void) loadData
{
    Store *store = [Store defaultStore];
    NSArray *auxUsers=  [store fetchAllObjectsofClass:[User class]];
    if(!auxUsers.count)
    {
        NSData *dataFromUsersJson=[[NSData alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"users" ofType:@"json"]];
        NSDictionary *dataSerializedFromJson = [NSJSONSerialization JSONObjectWithData:dataFromUsersJson options:0 error:nil];
        NSDictionary * usersFromJSon = dataSerializedFromJson[@"users"];
        
        for( NSDictionary *userDictionary in usersFromJSon )
        {
            User* user = [User new];
            [user fromDictionary:userDictionary];
            [store addObject:user];
        }
        
        [store save];
    }
    
    NSArray *auxArticles =[store fetchAllObjectsofClass:[Article class]];
    if(!auxArticles.count) {
        NSURL *url = [NSURL URLWithString:@"http://yourtake.tumblr.com/api/read/json"];
        NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url
                                                                 completionHandler:^(NSData *data,
                                                                                     NSURLResponse *response,
                                                                                     NSError *error)
                                      {
                                          NSString *tempString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                          NSString *modifiedString = [tempString substringToIndex:tempString.length - 2];
                                          modifiedString = [modifiedString substringFromIndex:22];
                                          data = [modifiedString dataUsingEncoding:NSUTF8StringEncoding];
                                          NSDictionary *dataSerialized = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                          NSDictionary *articlesFromJSon = dataSerialized[@"posts"];
                                          
                                          for( NSDictionary *article in articlesFromJSon)
                                          {
                                              if ([[article valueForKey:@"type" ] isEqualToString:@"photo"] )
                                              {
                                                  Article *newArticle = [[Article alloc] init];
                                                  [newArticle fromDictionary:article];
                                                  [store addObject:newArticle];
                                                  
                                              }
                                          }
                                          [store save];
                                      }];
        [task resume];
        
    }


        
}
@end
