//
//  AMZNOperationDispatcher.h
//  TestApp
//
//  Copyright (c) 2015 Cloud Drive. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AMZNConcurrentOperation;

@interface AMZNOperationDispatcher : NSObject

- (instancetype)initWithDispatchQueue:(NSOperationQueue *)queue;

/**
 Dispatch operation with blocking the running thread, returning an NSError in the given out parameter in case of failure.
 */
- (id)dispatchOperationSynchronously:(AMZNConcurrentOperation *)operation error:(NSError **)error;

/**
 Dispatch operation without blocking the running thread.
 */
- (void)dispatchOperationAsynchronously:(AMZNConcurrentOperation *)operation completion:(void(^)(id result, NSError *error))completion;

@end
