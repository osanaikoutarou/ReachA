//
//  AMZNAccountManager.m
//  TestApp
//
//  Copyright (c) 2015 Cloud Drive. All rights reserved.
//

#import "AMZNAccountManager.h"
#import "AMZNOperationDispatcher.h"
#import "AMZNLoginOperation.h"
#import "AMZNLogoutOperation.h"

@interface AMZNAccountManager()

@property (nonatomic) AMZNOperationDispatcher *operationDispatcher;

@end

@implementation AMZNAccountManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.operationDispatcher = [[AMZNOperationDispatcher alloc] initWithDispatchQueue:[NSOperationQueue mainQueue]];
    }
    return self;
}

+ (instancetype)sharedProvider
{
    static AMZNAccountManager *_shared = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        _shared = [AMZNAccountManager new];
    });
    return _shared;
}

- (void)loginAsynchronously:(void(^)(id result, NSError *error))completion
{
    AMZNLoginOperation *operation = [AMZNLoginOperation new];
    [self.operationDispatcher dispatchOperationAsynchronously:operation completion:^(id result, NSError *error) {
        if (completion) {
            completion(result, error);
        }
    }];
}

- (void)logoutAsynchronously:(void(^)(id result, NSError *error))completion
{
    AMZNLogoutOperation *operation = [AMZNLogoutOperation new];
    [self.operationDispatcher dispatchOperationAsynchronously:operation completion:^(id result, NSError *error) {
        if (completion) {
            completion(result, error);
        }
    }];
}

@end
