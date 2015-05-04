//
//  SHObject+ParseObject.h
//  SHParseSDKWrapper
//
//  Created by WuShengHua on 5/4/15.
//  Copyright (c) 2015 ShengHuaWu. All rights reserved.
//

#import "SHObject.h"

@class PFObject;

/**
 *  This category is used to create direct connection between SHObject and PFObject.
 *  It might be appropriate NOT to use this category in your production codebase,
 *  because it is possible to replace Parsr.com service in the future.
 */

@interface SHObject (ParseObject)

+ (instancetype)objectWithParseObject:(PFObject *)parseObject;

@end
