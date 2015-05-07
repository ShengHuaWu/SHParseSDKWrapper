//
//  SHQuery.m
//  SHParseSDKWrapper
//
//  Created by WuShengHua on 5/3/15.
//  Copyright (c) 2015 ShengHuaWu. All rights reserved.
//

#import "SHQuery.h"
#import <Parse.h>
#import "SHObject.h"
#import "SHObject+ParseObject.h"

@interface SHQuery ()

@property (nonatomic, strong) PFQuery *query;

@end

@implementation SHQuery

#pragma mark - Creation
+ (instancetype)queryWithClassName:(NSString *)name
{
    return [[self alloc] initWithClassName:name];
}

+ (instancetype)queryWithClassName:(NSString *)name predicate:(NSPredicate *)predicate
{
    return [[self alloc] initWithClassName:name predicate:predicate];
}

#pragma mark - Designated initializer
- (instancetype)initWithClassName:(NSString *)name
{
    self = [super init];
    if (self) {
        _query = [PFQuery queryWithClassName:name];
    }
    return self;
}

- (instancetype)initWithClassName:(NSString *)name predicate:(NSPredicate *)predicate
{
    self = [super init];
    if (self) {
        _query = [PFQuery queryWithClassName:name predicate:predicate];
    }
    return self;
}

#pragma mark - Limit
- (void)setLimit:(NSInteger)limit
{
    self.query.limit = limit;
}

#pragma mark - Finding object
- (void)findObjectInBackgroundWithID:(NSString *)objectID handler:(SHQueryFindingObjectCompletionHandler)handler
{
    [self.query getObjectInBackgroundWithId:objectID block:^(PFObject *parseObject,  NSError *error) {
        SHObject *object = nil;
        if (parseObject) {
            object = [SHObject objectWithParseObject:parseObject];
        }
        
        if (handler) {
            handler(object, error);
        }
    }];
}

- (void)findObjectsInBackgroundWithHandler:(SHQueryFindingObjectsCompletionHandler)hander
{
    [self.query findObjectsInBackgroundWithBlock:^(NSArray *parseObjects, NSError *error) {
        NSMutableArray *objects = [NSMutableArray array];
        for (PFObject *parseObject in parseObjects) {
            SHObject *object = [SHObject objectWithParseObject:parseObject];
            [objects addObject:object];
        }
        
        if (hander) {
            hander(objects, error);
        }
    }];
}

@end
