//
//  DataCenter.m
//  ArticlesProject
//
//  Created by Dan Toderici on 19/08/15.
//  Copyright (c) 2015 Dan Toderici. All rights reserved.
//

#import "DataCenter.h"
//#import "User.h"
//#import "Transaction.h"

@class User;
@class Transaction;
@interface DataCenter ()

@property (nonatomic) NSMutableArray *allUsers;
@property (nonatomic) NSMutableArray *allTransactions;
@property (nonatomic) NSMutableArray *allNews;

@end

@implementation DataCenter

+(DataCenter *)defaultDataCenter
{
    
    static DataCenter *defaultCenter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        defaultCenter = [[DataCenter alloc]init];
    });
    
    return defaultCenter;
}

//-(id) init
//{
//    self = [super init];
//    self.allUsers = [[NSMutableArray alloc]init];
//    self.allTransactions = [[NSMutableArray alloc]init];
//    self.allNews = [[NSMutableArray alloc]init];
//    
//    if(self)
//    {
//        self.allUsers = [self.store fetchAllObjectsofClass:[User class]];
//    
//    self.allTransactions =
//    //self.allNews =
//    }
//    
//   
//    return self;
//}
//
//
//-(id) listAllUsers
//{
//    NSArray *list = [self.store fetchAllObjectsofClass:[User class]];
//    return list;
//}
//
//-(BOOL) verifyIfExistingEmail:(NSString *)emailToVerify andPassword:(NSString *)passwordToVerify
//{
//    BOOL flag = false;
//    User* existingUser;
//    
//    for (int i = 0 ;i < [[self listAllUsers] count] ;i++ )
//    {
//        existingUser = [self.allUsers objectAtIndex:i];
//        NSLog(@"%@",existingUser);
//        if( [existingUser.email isEqualToString:emailToVerify] && [existingUser.password isEqualToString:passwordToVerify] )
//        {
//            flag = true;
//            break;
//        }
//    }
//    
//    return flag;
//}


@end
