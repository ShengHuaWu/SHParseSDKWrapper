//
//  SHObject.h
//  SHParseSDKWrapper
//
//  Created by WuShengHua on 5/1/15.
//  Copyright (c) 2015 ShengHuaWu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SHObjectSavingCompletionHandler) (BOOL success, NSError *error);
typedef void (^SHObjectDeletionCompletionHandler) (BOOL success, NSError *error);

@interface SHObject : NSObject

@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) NSDate *updatedAt;
@property (nonatomic, strong) NSString *objectID;

+ (instancetype)objectWithClassName:(NSString *)name attributes:(NSDictionary *)attributes;
+ (instancetype)objectWithClassName:(NSString *)name objectID:(NSString *)objectID;

- (void)setObject:(id)object forKeyedSubscript:(NSString *)key;
- (id)objectForKeyedSubscript:(NSString *)key;

- (void)saveInBackgroundWithHandler:(SHObjectSavingCompletionHandler)hander;
- (void)deleteInBackgroundWithHandler:(SHObjectDeletionCompletionHandler)hander;

@end
