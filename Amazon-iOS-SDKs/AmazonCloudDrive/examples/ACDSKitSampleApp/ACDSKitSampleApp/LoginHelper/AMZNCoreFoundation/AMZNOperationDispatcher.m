//
//  AMZNOperationDispatcher.m
//  TestApp
//
//  Copyright (c) 2015 Cloud Drive. All rights reserved.
//

#import "AMZNOperationDispatcher.h"
#import "AMZNConcurrentOperation.h"

@interface AMZNOperationDispatcher ()

@property (nonatomic) NSOperationQueue *dispatchQueue;

@end

@implementation AMZNOperationDispatcher

- (instancetype)init
{
    return [self initWithDispatchQueue:[NSOperationQueue new]];
}

- (instancetype)initWithDispatchQueue:(NSOperationQueue *)queue
{
    self = [super init];
    if (self) {
        self.dispatchQueue = queue;
    }
    return self;
}

- (id)dispatchOperationSynchronously:(AMZNConcurrentOperation *)operation error:(NSError **)error
{
    [self.dispatchQueue addOperation:operation];
    [operation waitUntilFinished];
    
    id result = operation.result;
    if (error) {
        *error = operation.error;
    }
    
    return result;
}

- (void)dispatchOperationAsynchronously:(AMZNConcurrentOperation *)operation completion:(void(^)(id result, NSError *error))completion
{
    __block __typeof__(operation) __weak weakop = operation;
    operation.completionBlock = ^{
        __typeof__(weakop) strongop = weakop;
        if (completion) {
            completion(strongop.result, strongop.error);
        }
    };
    [self.dispatchQueue addOperation:operation];
}

@end
