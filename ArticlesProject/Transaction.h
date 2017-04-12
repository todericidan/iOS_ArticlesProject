//
//  Transaction.h
//  ArticlesProject
//
//  Created by Dan Toderici on 20/08/15.
//  Copyright (c) 2015 Dan Toderici. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Encodable.h"

@interface Transaction : NSObject<Encodable>

@property(nonatomic) NSNumber *transactionId;
@property(nonatomic) NSNumber *userId;
@property(nonatomic) NSNumber *value;

@end
