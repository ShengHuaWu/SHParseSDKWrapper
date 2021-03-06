//
//  SHQueryTests.m
//  SHParseSDKWrapper
//
//  Created by WuShengHua on 5/3/15.
//  Copyright (c) 2015 ShengHuaWu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "SHParseSDK.h"
#import "SHQuery.h"
#import "SHObject.h"

@interface SHQueryTests : XCTestCase

@end

@implementation SHQueryTests

- (void)setUp
{
    [super setUp];
    
    [SHParseSDK setUpWithAppID:@"lyKHgK2z6bynUgNeiNah1bZomg3G4B8ccQTNE0gC" clientKey:@"SVoDj01HkW39TUeshwkGx30aA2pZeDdo5VAtOz0x"];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testFindSingleObject
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"Find Single Object"];
    
    SHQuery *query = [SHQuery queryWithClassName:@"Place"];
    [query findObjectInBackgroundWithID:@"VqrnVS9QYg" handler:^(SHObject *object, NSError *error) {
        XCTAssertNil(error, @"Finding failed: %@", [error localizedDescription]);
        XCTAssertNotNil(object, @"Do not find any object.");
        XCTAssertNotNil(object.objectID, @"Object ID is empty");
        XCTAssertNotNil(object.updatedAt, @"Updated date is empty");
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        XCTAssertNil(error, @"Error occur: %@", [error localizedDescription]);
    }];
}

- (void)testUpdateObjectAttributes
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"Update Object Attributes"];
    
    SHQuery *query = [SHQuery queryWithClassName:@"Place"];
    [query findObjectInBackgroundWithID:@"VqrnVS9QYg" handler:^(SHObject *object, NSError *error) {
        XCTAssertNil(error, @"Finding failed: %@", [error localizedDescription]);
        
        object[@"name"] = @"we're family";
        object[@"phone"] = @"987654";
        
        [object saveInBackgroundWithHandler:^(BOOL success, NSError *error) {
            XCTAssert(success, @"Updating failed: %@", [error localizedDescription]);
            
            [expectation fulfill];
        }];
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        XCTAssertNil(error, @"Error occur: %@", [error localizedDescription]);
    }];
}

- (void)testFindObjectsWithPredicate
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"Find Objects with Predicate"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"address == %@", @"taipei"];
    SHQuery *query = [SHQuery queryWithClassName:@"Place" predicate:predicate];
    [query findObjectsInBackgroundWithHandler:^(NSArray *objects, NSError *error) {
        XCTAssertNil(error, @"Finding failed: %@", [error localizedDescription]);
        XCTAssertEqual([objects count], 2, @"Number of objects is wrong.");
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        XCTAssertNil(error, @"Error occur: %@", [error localizedDescription]);
    }];
}

@end
