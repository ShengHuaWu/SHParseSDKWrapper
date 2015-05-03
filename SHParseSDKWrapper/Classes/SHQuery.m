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

@interface SHQuery ()

@property (nonatomic, strong) PFQuery *query;

@end

@implementation SHQuery

#pragma mark - Creation
+ (instancetype)queryWithClassName:(NSString *)name
{
    return [[self alloc] initWithClassName:name];
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

#pragma mark - Finding object
- (void)findObjectWithID:(NSString *)objectID handler:(SHQueryFindingObjectCompletionHandler)handler
{
    [self.query getObjectInBackgroundWithId:objectID block:^(PFObject *parseObject,  NSError *error) {
        SHObject *object = nil;
        if (parseObject) {
            object = [SHObject objectWithClassName:parseObject.parseClassName objectID:parseObject.objectId];
            object.createdAt = parseObject.createdAt;
            object.updatedAt = parseObject.updatedAt;
            for (NSString *key in [parseObject allKeys]) {
                object[key] = parseObject[key];
            }
        }
        
        if (handler) {
            handler(object, error);
        }
    }];
}

@end
