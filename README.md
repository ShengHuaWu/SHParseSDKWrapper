# SHParseSDKWrapper
This project provides some APIs that wraps Parse.com SDK.

## SHParseSDK
Set up

    + (void)setUpWithAppID:(NSString *)appID clientKey:(NSString *)key;

## SHObject
Create an object with attributes

    + (instancetype)objectWithClassName:(NSString *)name attributes:(NSDictionary *)attributes;

Create an object with corresponding identifier

    + (instancetype)objectWithClassName:(NSString *)name objectID:(NSString *)objectID;

Save and delete an object

    - (void)saveInBackgroundWithHandler:(SHObjectSavingCompletionHandler)hander;
    - (void)deleteInBackgroundWithHandler:(SHObjectDeletionCompletionHandler)hander;

## SHQuery
Create a query

    + (instancetype)queryWithClassName:(NSString *)name;
    + (instancetype)queryWithClassName:(NSString *)name predicate:(NSPredicate *)predicate;

Find object

    - (void)findObjectInBackgroundWithID:(NSString *)objectID handler:(SHQueryFindingObjectCompletionHandler)handler;
    - (void)findObjectsInBackgroundWithHandler:(SHQueryFindingObjectsCompletionHandler)hander;
