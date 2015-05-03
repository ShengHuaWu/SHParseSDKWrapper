//
//  SHParseSDK.m
//  SHParseSDKWrapper
//
//  Created by WuShengHua on 5/1/15.
//  Copyright (c) 2015 ShengHuaWu. All rights reserved.
//

#import "SHParseSDK.h"
#import <Parse.h>

@implementation SHParseSDK

#pragma mark - Set up
+ (void)setUpWithAppID:(NSString *)appID clientKey:(NSString *)key
{
    [Parse setApplicationId:appID clientKey:key];
}

@end
