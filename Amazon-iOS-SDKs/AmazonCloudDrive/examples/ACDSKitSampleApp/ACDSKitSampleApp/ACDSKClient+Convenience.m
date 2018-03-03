//
//  ACDSKClient+Convenience.m
//  ACDSKitSampleApp
//
//  Copyright (c) 2015 Cloud Drive. All rights reserved.
//

#import "ACDSKClient+Convenience.h"
#import "AMZNAuthorizationProvider.h"

@implementation ACDSKClient (Convenience)

#pragma mark - Shared

static id _sharedInstance = nil;

+ (instancetype)sharedInstance {
    @synchronized(self) {
        if (_sharedInstance == nil) {
            _sharedInstance = [self clientWithTokenProvider:^NSString *{
                NSError *error = nil;
                return [[AMZNAuthorizationProvider sharedProvider] fetchAuthTokenSynchronously:&error];
            }];
        }
        return _sharedInstance;
    }
}

+ (void)resetSharedInstance {
    @synchronized(self) {
        _sharedInstance = nil;
    }
}

#pragma mark - Requests

- (ACDSKTask *)listRootNode:(void (^)(NSError *))errorHandler success:(void (^)(ACDSKListNodesResponse *))successHandler {
    ACDSKListNodesRequest *listRootNodeRequest = [ACDSKListNodesRequest new];
    listRootNodeRequest.filters = @"isRoot:true";
    return [self listNodes:listRootNodeRequest fail:^(NSError *error) {
        if (errorHandler) {
            errorHandler(error);
        }
    } success:^(ACDSKListNodesResponse *response) {
        if (successHandler) {
            successHandler(response);
        }
    }];
}

@end
