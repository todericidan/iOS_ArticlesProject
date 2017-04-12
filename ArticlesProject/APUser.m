//
//  APUser.m
//  ArticlesProject
//
//  Created by Dan Toderici on 21/08/15.
//  Copyright (c) 2015 Dan Toderici. All rights reserved.
//

#import "APUser.h"

@implementation APUser

+(APUser *) defaultUser
{
    static APUser *defaultUser = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        defaultUser = [[APUser alloc]init];
    });
    return defaultUser;
}

-(void)initWithUser:(User*)user
{
        self.details = user;
    
}

-(void) userHasLoggeOut;
{
    self.details = nil;
}

@end
