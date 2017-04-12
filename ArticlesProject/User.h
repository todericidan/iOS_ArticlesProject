//
//  User.h
//  ArticlesProject
//
//  Created by Dan Toderici on 19/08/15.
//  Copyright (c) 2015 Dan Toderici. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Encodable.h"

@interface User : NSObject <Encodable>

@property(nonatomic) NSNumber *ID;
@property(nonatomic) NSString *firstName;
@property(nonatomic) NSString *lastName;
@property(nonatomic) NSString *email;
@property(nonatomic) NSNumber *age;
@property(nonatomic) NSString *occupation;
@property(nonatomic) NSNumber *credit;
@property(nonatomic) NSNumber *isAdmin;
@property(nonatomic) NSString *password;
@property(nonatomic) NSNumber *requestedCredit;
//@property

@end
