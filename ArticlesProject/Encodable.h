//
//  Encodable.h
//  ArticlesProject
//
//  Created by Dan Toderici on 19/08/15.
//  Copyright (c) 2015 Dan Toderici. All rights reserved.
//

@protocol Encodable <NSObject>
@required
-(void) fromDictionary:(NSDictionary *)dictionary;
-(NSDictionary*) dictionary;
@property (nonatomic)NSNumber *ID;

@end