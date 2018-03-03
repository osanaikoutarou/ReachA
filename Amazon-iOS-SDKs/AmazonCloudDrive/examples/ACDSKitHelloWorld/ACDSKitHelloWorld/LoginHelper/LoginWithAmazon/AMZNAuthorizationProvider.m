//
//  AMZNAuthorizationProvider.m
//  TestApp
//
//  Copyright (c) 2015 Cloud Drive. All rights reserved.
//

#import "AMZNAuthorizationProvider.h"
#import <LoginWithAmazon/LoginWithAmazon.h>
#import "AMZNOperationDispatcher.h"
#import "AMZNGetAuthTokenOperation.h"
#import "NSError+LoginWithAmazon.h"

@interface AMZNAuthorizationProvider()

@property (nonatomic) AMZNOperationDispatcher *operationDispatcher;

@end

@implementation AMZNAuthorizationProvider

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.operationDispatcher = [[AMZNOperationDispatcher alloc] initWithDispatchQueue:[NSOperationQueue mainQueue]];
    }
    return self;
}

+ (id)sharedProvider
{
    static AMZNAuthorizationProvider *_shared = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        _shared = [AMZNAuthorizationProvider new];
    });
    return _shared;
}

- (NSString *)fetchAuthTokenSynchronously:(NSError **)error
{
    if ([NSThread isMainThread] == YES) {
        if (error) {
            *error = [NSError unsupportedTaskOnMainThreadError];
        }
        return @"";
    }
    
    AMZNGetAuthTokenOperation *operation = [AMZNGetAuthTokenOperation new];
    NSString *authToken = [self.operationDispatcher dispatchOperationSynchronously:operation error:error];
    if (authToken == nil) {
        authToken = @"";
    }
    return authToken;
}

- (void)fetchAuthTokenAsynchronously:(void(^)(id result, NSError *error))completion
{
    AMZNGetAuthTokenOperation *operation = [AMZNGetAuthTokenOperation new];
    [self.operationDispatcher dispatchOperationAsynchronously:operation completion:completion];
}

@end
