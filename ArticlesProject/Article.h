//
//  Article.h
//  ArticlesProject
//
//  Created by Dan Toderici on 25/08/15.
//  Copyright (c) 2015 Dan Toderici. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Encodable.h"

@interface Article : NSObject<Encodable>

@property (nonatomic) NSNumber* ID;
@property (nonatomic) NSString* title;
@property (nonatomic) NSString* shortDescription;
@property (nonatomic) NSString* imageURl;
@property (nonatomic) NSString* webpageURL;

@end
