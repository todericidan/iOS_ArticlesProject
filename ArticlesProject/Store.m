//
//  Store.m
//  ArticlesProject
//
//  Created by Dan Toderici on 19/08/15.
//  Copyright (c) 2015 Dan Toderici. All rights reserved.
//

#import "Store.h"
#import "User.h"

@interface Store()

@property(nonatomic)NSMutableDictionary *inventory;


@end

@implementation Store
+(Store *) defaultStore
{
    static Store *defaultStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        defaultStore = [[Store alloc]init];
    });
    return defaultStore;
}

-(void)save
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.inventory forKey:@"myKey"];
    
    [defaults synchronize];
}

-(instancetype)init
{
    self = [super init];
    if(![[NSUserDefaults standardUserDefaults] objectForKey:@"myKey"] )
    {
        self.inventory = [NSMutableDictionary new];
    }
    else
    {
        self.inventory=[[NSUserDefaults standardUserDefaults] objectForKey:@"myKey"];
    }
    return self;
}

-(void) addObject:(id<Encodable>)object
{
    NSString *key = NSStringFromClass([object class]);
    if(!self.inventory[key])
    {
        self.inventory[key]=[NSMutableArray array];
        
    }
    
    [self.inventory[key] addObject:[object dictionary]];
    
}

-(void)removeObjectForKey: (NSString*)givenKey
{
    [self.inventory removeObjectForKey:givenKey];
}

-(NSMutableArray*) fetchAllObjectsofClass:(Class)objectClass
{
    NSString *key = NSStringFromClass([objectClass class]);
    Class classType = NSClassFromString(key);
    NSMutableArray *auxArrayWithObjects = [NSMutableArray array];
    if(self.inventory[key])
    {
        for(NSDictionary *auxDictionary in self.inventory[key])
        {
            id<Encodable> object = [classType new];
            if([object conformsToProtocol:NSProtocolFromString(@"Encodable")])
            {
                
                [object fromDictionary:auxDictionary];
                [auxArrayWithObjects addObject:object];
            }
        }
        return auxArrayWithObjects;
    }
    else
    {
        return nil;
    }
}

-(void) updateObject:(id <Encodable>)object
{
    NSString *key= NSStringFromClass([object class]);
    if(self.inventory[key])
    {
        NSPredicate *predicate=[NSPredicate predicateWithFormat:@"self.id= %@ ",object.ID];
        
       NSDictionary *obj= [[self.inventory[key] filteredArrayUsingPredicate:predicate] lastObject];
        [self.inventory[key] removeObject:obj];
        [self.inventory[key] addObject:[object dictionary]];
        
    }
    
}



@end
