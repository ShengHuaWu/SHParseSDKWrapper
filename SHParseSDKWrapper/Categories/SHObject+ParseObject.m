//
//  SHObject+ParseObject.m
//  SHParseSDKWrapper
//
//  Created by WuShengHua on 5/4/15.
//  Copyright (c) 2015 ShengHuaWu. All rights reserved.
//

#import "SHObject+ParseObject.h"
#import <Parse.h>

@implementation SHObject (ParseObject)

#pragma mark - Creation
+ (instancetype)objectWithParseObject:(PFObject *)parseObject
{
    SHObject *object = [SHObject objectWithClassName:parseObject.parseClassName objectID:parseObject.objectId];
    object.createdAt = parseObject.createdAt;
    object.updatedAt = parseObject.updatedAt;
    for (NSString *key in [parseObject allKeys]) {
        object[key] = parseObject[key];
    }
    
    return object;
}

@end
