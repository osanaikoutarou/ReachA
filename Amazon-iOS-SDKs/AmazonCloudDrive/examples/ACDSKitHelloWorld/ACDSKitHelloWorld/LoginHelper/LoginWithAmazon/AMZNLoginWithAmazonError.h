//
//  AMZNLoginWithAmazonError.h
//  TestApp
//
//  Copyright (c) 2015 Cloud Drive. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *AMZNLoginWithAmazonErrorDomain;

/**
 Login errors
 */
typedef NS_OPTIONS(NSInteger, AMZNLoginWithAmazonError) {
    AMZNLoginWithAmazonErrorUnknown = -10000
    , AMZNLoginWithAmazonErrorUnsupportedTaskOnMainThread
};
