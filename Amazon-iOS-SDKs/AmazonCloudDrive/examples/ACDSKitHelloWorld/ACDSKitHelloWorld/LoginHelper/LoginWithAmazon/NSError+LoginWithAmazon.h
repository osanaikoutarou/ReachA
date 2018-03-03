//
//  NSError+LoginWithAmazon.h
//  ACDSKitSampleApp
//
//  Copyright (c) 2015 Cloud Drive. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSError (LoginWithAmazon)

+ (NSError *)unsupportedTaskOnMainThreadError;
+ (NSError *)unknownLoginWithAmazonError;

@end
