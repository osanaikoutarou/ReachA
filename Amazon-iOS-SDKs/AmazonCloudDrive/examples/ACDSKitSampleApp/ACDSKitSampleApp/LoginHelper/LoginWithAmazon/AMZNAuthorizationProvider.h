//
//  AMZNAuthorizationProvider.h
//  TestApp
//
//  Copyright (c) 2015 Cloud Drive. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AMZNAuthorizationProvider : NSObject

+ (id)sharedProvider;

/**
 Fetch access token from LWA with blocking the running thread.
 
 Note that this method MUST be called on the non-main thread otherwise AMZNLoginWithAmazonErrorUnsupportedTaskOnMainThread error will happen.
 */
- (NSString *)fetchAuthTokenSynchronously:(NSError **)error;

/**
 Fetch access token from LWA without blocking the running thread.
 */
- (void)fetchAuthTokenAsynchronously:(void(^)(id result, NSError *error))completion;

@end
