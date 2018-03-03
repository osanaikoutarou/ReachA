//
//  AMZNAccountManager.h
//  TestApp
//
//  Copyright (c) 2015 Cloud Drive. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AMZNAccountManager : NSObject

+ (instancetype)sharedProvider;
- (void)loginAsynchronously:(void(^)(id result, NSError *error))completion;
- (void)logoutAsynchronously:(void(^)(id result, NSError *error))completion;

@end
