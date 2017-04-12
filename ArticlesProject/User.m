//
//  User.m
//  ArticlesProject
//
//  Created by Dan Toderici on 19/08/15.
//  Copyright (c) 2015 Dan Toderici. All rights reserved.
//

#import "User.h"


@implementation User

-(void) fromDictionary:(NSDictionary *)dictionary
{
        self.ID = dictionary[@"id"];
        self.firstName =dictionary[@"firstName"];
        self.lastName = dictionary [@"lastName"];
        self.email = dictionary [@"email"];
        self.age = dictionary [@"age"];
        self.occupation = dictionary [@"occupation"];
        self.credit = dictionary [@"credit"];
        self.isAdmin = dictionary [@"admin"];
        self.password = dictionary [@"password"];
       self.requestedCredit = dictionary [@"requestedCredit"];
    
}

-(NSDictionary*) dictionary
{
    return @{
             @"id":self.ID,
             @"firstName":self.firstName,
             @"lastName":self.lastName,
             @"email":self.email,
             @"age":self.age,
             @"occupation":self.occupation,
             @"credit":self.credit?self.credit:@0,
             @"admin":self.isAdmin,
             @"password":self.password,
             @"requestedCredit":self.requestedCredit?self.requestedCredit:@0
             };
}


-(NSString*) description
{
    return [NSString stringWithFormat:@"%@ | %@ ", self.email,self.password];
}

@end
