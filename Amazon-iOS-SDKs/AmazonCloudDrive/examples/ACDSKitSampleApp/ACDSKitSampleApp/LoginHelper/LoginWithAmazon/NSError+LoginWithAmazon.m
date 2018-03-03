//
//  NSError+LoginWithAmazon.m
//  ACDSKitSampleApp
//
//  Copyright (c) 2015 Cloud Drive. All rights reserved.
//

#import "NSError+LoginWithAmazon.h"
#import "AMZNLoginWithAmazonError.h"

@implementation NSError (LoginWithAmazon)

+ (NSError *)unsupportedTaskOnMainThreadError
{
    return [NSError errorWithDomain:AMZNLoginWithAmazonErrorDomain code:AMZNLoginWithAmazonErrorUnsupportedTaskOnMainThread
                           userInfo:@{NSLocalizedDescriptionKey: @"Unsupported method call on main thread!"}];

}

+ (NSError *)unknownLoginWithAmazonError
{
    return [NSError errorWithDomain:AMZNLoginWithAmazonErrorDomain code:AMZNLoginWithAmazonErrorUnknown
                           userInfo:@{NSLocalizedDescriptionKey: @"unknown error"}];
}

@end
