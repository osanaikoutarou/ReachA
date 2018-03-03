//
//  AMZNGetAuthTokenOperation.m
//  TestApp
//
//  Copyright (c) 2015 Cloud Drive. All rights reserved.
//

#import "AMZNGetAuthTokenOperation.h"
#import <LoginWithAmazon/LoginWithAmazon.h>
#import "AMZNLoginWithAmazonConstants.h"
#import "AMZNLoginWithAmazonError.h"
#import "NSError+LoginWithAmazon.h"

@interface AMZNGetAuthTokenOperation () <AIAuthenticationDelegate>

@end

@implementation AMZNGetAuthTokenOperation

- (void)start
{
    [super start];
    if (self.isCancelled) {
        return;
    }
    [AIMobileLib getAccessTokenForScopes:kAMZNCloudDriveAccessTokenActiveScope withOverrideParams:nil delegate:self];
}

#pragma mark - AIAuthenticationDelegate

- (void)requestDidSucceed:(APIResult *)apiResult
{
    NSString *token = apiResult.result;
    if (token.length > 0) {
        [self finishWithResult:token];
    } else {
        NSError *error = [NSError unknownLoginWithAmazonError];
        [self failWithError:error];
    }
}

- (void)requestDidFail:(APIError *)errorResponse
{
    NSError *error = [NSError errorWithDomain:AMZNLoginWithAmazonErrorDomain code:errorResponse.error.code userInfo:@{NSLocalizedDescriptionKey: errorResponse.error.message}];
    [self failWithError:error];
}

@end
