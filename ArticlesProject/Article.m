//
//  Article.m
//  ArticlesProject
//
//  Created by Dan Toderici on 25/08/15.
//  Copyright (c) 2015 Dan Toderici. All rights reserved.
//

#import "Article.h"

@implementation Article


-(void) fromDictionary:(NSDictionary *)dictionary
{
    self.ID = dictionary[@"id"];
    self.title =dictionary[@"slug"];
    self.shortDescription = dictionary [@"photo-caption"];
    self.imageURl = dictionary [@"photo-url-75"];
    self.webpageURL = dictionary [@"url"];
}

-(NSDictionary*) dictionary
{
    return @{
             @"id":self.ID,
             @"slug":self.title,
             @"photo-caption":self.shortDescription,
             @"photo-url-75":self.imageURl,
             @"url":self.webpageURL
             };
}


-(NSString*) description
{
    return [NSString stringWithFormat:@"%@ | %@ | %@", self.title,self.imageURl,self.webpageURL];
}

@end
