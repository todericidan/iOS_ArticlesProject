//
//  Transaction.m
//  ArticlesProject
//
//  Created by Dan Toderici on 20/08/15.
//  Copyright (c) 2015 Dan Toderici. All rights reserved.
//

#import "Transaction.h"

@implementation Transaction

-(void) fromDictionary:(NSDictionary *)dictionary
{
    self.userId = dictionary[@"userId"];
    self.transactionId =dictionary[@"id"];
    self.value= dictionary [@"value"];
    
}

-(NSDictionary*) dictionary
{
    return @{
             @"id":self.transactionId,
             @"userId":self.userId,
             @"value":self.value
            };
}


-(NSString*) description
{
    return [NSString stringWithFormat:@"%@ | %@ | %@", self.transactionId,self.userId,self.value];
}

@end
