//
//  APUser.h
//  ArticlesProject
//
//  Created by Dan Toderici on 21/08/15.
//  Copyright (c) 2015 Dan Toderici. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface APUser : NSObject

@property(nonatomic) User *details;
+(APUser *) defaultUser;
-(void) userHasLoggeOut;
-(void)initWithUser:(User*)user;

@end
