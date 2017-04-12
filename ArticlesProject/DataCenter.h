//
//  DataCenter.h
//  ArticlesProject
//
//  Created by Dan Toderici on 19/08/15.
//  Copyright (c) 2015 Dan Toderici. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Store.h"

@interface DataCenter : NSObject

+(DataCenter *)defaultDataCenter ;
-(id) listAllUsers;
-(BOOL) verifyIfExistingEmail:(NSString *)emailToVerify andPassword:(NSString *)passwordToVerify;

@property(nonatomic)Store* store;

@end
