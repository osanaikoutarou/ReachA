//
//  AMZNLoginOperation.m
//  TestApp
//
//  Copyright (c) 2015 Cloud Drive. All rights reserved.
//

#import "AMZNLoginOperation.h"
#import <LoginWithAmazon/LoginWithAmazon.h>
#import "AMZNLoginWithAmazonConstants.h"
#import "AMZNLoginWithAmazonError.h"

@interface AMZNLoginOperation() <AIAuthenticationDelegate>

@end

@implementation AMZNLoginOperation

- (void)start
{
    [super start];
    if (self.isCancelled) {
        return;
    }
    [AIMobileLib authorizeUserForScopes:kAMZNCloudDriveAccessTokenActiveScope delegate:self];
}

#pragma mark - AIAuthenticationDelegate

- (void)requestDidSucceed:(APIResult *)apiResult
{
    [self finishWithResult:nil];
}

- (void)requestDidFail:(APIError *)errorResponse
{
    NSError *error = [NSError errorWithDomain:AMZNLoginWithAmazonErrorDomain code:errorResponse.error.code userInfo:@{NSLocalizedDescriptionKey: errorResponse.error.message}];
    [self failWithError:error];
}

@end
