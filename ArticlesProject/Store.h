//
//  Store.h
//  ArticlesProject
//
//  Created by Dan Toderici on 19/08/15.
//  Copyright (c) 2015 Dan Toderici. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Encodable.h"
@class User;
@class Article;
@interface Store : NSObject

+(Store *) defaultStore;
-(void) save;
-(void)removeObjectForKey: (NSString*)givenKey;
-(NSMutableArray*) fetchAllObjectsofClass:(Class)objectClass;
-(void) addObject:(id<Encodable>)object;
-(void) updateObject:(id <Encodable>)object;
@property(nonatomic)User *loggedInUser;
@property(nonatomic)User *selectedUser;//de proba
@property(nonatomic)Article *selectedArticle;

@end
