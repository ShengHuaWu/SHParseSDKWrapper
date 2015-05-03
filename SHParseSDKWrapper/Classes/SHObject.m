//
//  SHObject.m
//  SHParseSDKWrapper
//
//  Created by WuShengHua on 5/1/15.
//  Copyright (c) 2015 ShengHuaWu. All rights reserved.
//

#import "SHObject.h"
#import <Parse.h>

@interface SHObject ()

@property (nonatomic, strong) PFObject *parseObject;

@end

@implementation SHObject

#pragma mark - Creation
+ (instancetype)objectWithClassName:(NSString *)name attributes:(NSDictionary *)attributes
{
    return [[self alloc] initWithClassName:name attributes:attributes];
}

+ (instancetype)objectWithClassName:(NSString *)name objectID:(NSString *)objectID
{
    return [[self alloc] initWithClassName:name objectID:objectID];
}


#pragma mark - Designated initializer
- (instancetype)initWithClassName:(NSString *)name
{
    self = [super init];
    if (self) {
        _parseObject = [PFObject objectWithClassName:name];
    }
    return self;
}

#pragma mark - Convenience initializer
- (instancetype)initWithClassName:(NSString *)name attributes:(NSDictionary *)attributes
{
    self = [self initWithClassName:name];
    if (self) {
        for (NSString *key in attributes) {
            _parseObject[key] = attributes[key];
        }
    }
    return self;
}

- (instancetype)initWithClassName:(NSString *)name objectID:(NSString *)objectID
{
    self = [self initWithClassName:name];
    if (self) {
        _objectID = objectID;
        _parseObject.objectId = objectID;
    }
    return self;
}

#pragma mark - Attributes
- (void)setObject:(id)object forKeyedSubscript:(NSString *)key
{
    if (!object) return;
    
    self.parseObject[key] = object;
}

- (id)objectForKeyedSubscript:(NSString *)key
{
    return self.parseObject[key];
}

#pragma mark - Saving
- (void)saveInBackgroundWithHandler:(SHObjectSavingCompletionHandler)hander
{
    SHObject *__weak weakSelf = self;
    [self.parseObject saveInBackgroundWithBlock:^(BOOL success, NSError *error) {
        if (success) {
            weakSelf.createdAt = weakSelf.parseObject.createdAt;
            weakSelf.updatedAt = weakSelf.parseObject.updatedAt;
            weakSelf.objectID = weakSelf.parseObject.objectId;
        }
        
        if (hander) {
            hander(success, error);
        }
    }];
}

#pragma mark - Deletion
- (void)deleteInBackgroundWithHandler:(SHObjectDeletionCompletionHandler)hander
{
    [self.parseObject deleteInBackgroundWithBlock:^(BOOL success, NSError *error) {
        if (hander) {
            hander(success, error);
        }
    }];
}

@end
