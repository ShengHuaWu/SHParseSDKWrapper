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
typedef void (^SHQueryFindingObjectsCompletionHandler) (NSArray *objects, NSError *error);

@interface SHQuery : NSObject

+ (instancetype)queryWithClassName:(NSString *)name;
+ (instancetype)queryWithClassName:(NSString *)name predicate:(NSPredicate *)predicate;

- (void)setLimit:(NSInteger)limit;

- (void)findObjectInBackgroundWithID:(NSString *)objectID handler:(SHQueryFindingObjectCompletionHandler)handler;
- (void)findObjectsInBackgroundWithHandler:(SHQueryFindingObjectsCompletionHandler)hander;

@end
