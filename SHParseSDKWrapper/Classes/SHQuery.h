//
//  SHQuery.h
//  SHParseSDKWrapper
//
//  Created by WuShengHua on 5/3/15.
//  Copyright (c) 2015 ShengHuaWu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SHObject;

typedef void (^SHQueryFindingObjectCompletionHandler) (SHObject *object, NSError *error);

@interface SHQuery : NSObject

+ (instancetype)queryWithClassName:(NSString *)name;

- (void)findObjectWithID:(NSString *)objectID handler:(SHQueryFindingObjectCompletionHandler)handler;

@end
