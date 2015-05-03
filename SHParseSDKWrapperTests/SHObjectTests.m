//
//  SHObjectTests.m
//  SHParseSDKWrapper
//
//  Created by WuShengHua on 5/1/15.
//  Copyright (c) 2015 ShengHuaWu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "SHParseSDK.h"
#import "SHObject.h"

@interface SHObjectTests : XCTestCase

@end

@implementation SHObjectTests

- (void)setUp
{
    [super setUp];
    
    [SHParseSDK setUpWithAppID:@"lyKHgK2z6bynUgNeiNah1bZomg3G4B8ccQTNE0gC" clientKey:@"SVoDj01HkW39TUeshwkGx30aA2pZeDdo5VAtOz0x"];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testCreateSingleObject
{
    XCTestExpectation * expectation = [self expectationWithDescription:@"Create Single Object"];
    
    NSDictionary *attributes = @{@"name":@"7-11", @"address": @"taipei", @"phone": @"12345"};
    SHObject *object = [SHObject objectWithClassName:@"Place" attributes:attributes];
    [object saveInBackgroundWithHandler:^(BOOL success, NSError *error) {
        XCTAssert(success, @"Saving failed: %@", [error localizedDescription]);
        
        XCTAssertNotNil(object.objectID, @"Object ID is empty.");
        XCTAssertNotNil(object.createdAt, @"Created date is empty.");
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        XCTAssertNil(error, @"Error occur: %@", [error localizedDescription]);
    }];
}

- (void)testDeleteSingleObject
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"Delete Single Object"];
    
    SHObject *object = [SHObject objectWithClassName:@"Place" objectID:@"YAAfptaptX"];
    [object deleteInBackgroundWithHandler:^(BOOL success, NSError *error) {
        XCTAssert(success, @"Deletion failed: %@", [error localizedDescription]);

        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        XCTAssertNil(error, @"Error occur: %@", [error localizedDescription]);
    }];
}

@end
