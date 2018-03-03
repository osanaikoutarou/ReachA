//
//  ACDSKClient+Convenience.h
//  ACDSKitSampleApp
//
//  Copyright (c) 2015 Cloud Drive. All rights reserved.
//

#import <ACDSKit/ACDSKit.h>

@interface ACDSKClient (Convenience)

///---------------------
/// @name Shared
///---------------------

/**
 Shared instance of ACDSKClient. Uses AMZNAuthorizationProvider as its auth token provider.
 */
+ (instancetype)sharedInstance;

/**
 Resets the shared instance of ACDSKClient. Should be called on logout.
 */
+ (void)resetSharedInstance;

///---------------------
/// @name Requests
///---------------------

/**
 Convenience method for listing root node.
 @param errorHandler Notify the caller that the request failed.
 @param successHandler Notify the caller the request has completed successfully.
 @return an ACDSKTask object representing the asynchronous call.
 @see ACDSKListNodesResponse
 */
- (ACDSKTask *)listRootNode:(void(^)(NSError *error))errorHandler
                    success:(void(^)(ACDSKListNodesResponse *response))successHandler;

@end
