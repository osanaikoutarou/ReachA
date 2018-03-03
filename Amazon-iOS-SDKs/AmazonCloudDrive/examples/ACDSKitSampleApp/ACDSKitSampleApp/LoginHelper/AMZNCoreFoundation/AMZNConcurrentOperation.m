//
//  AMZNConcurrentOperation.m
//  CloudDrivePhotosiOS
//
//  Copyright (c) 2014 Cloud Drive. All rights reserved.
//

#import "AMZNConcurrentOperation.h"

@interface AMZNConcurrentOperation ()

@property (nonatomic) id result;
@property (nonatomic) NSError *error;
@property (assign) BOOL running;
@property (assign) BOOL completed;

@end

@implementation AMZNConcurrentOperation

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key
{
    NSMutableSet *keyPaths = [[super keyPathsForValuesAffectingValueForKey:key] mutableCopy];
    if ([key isEqualToString:@"isExecuting"]) {
        [keyPaths addObject:@"running"];
    } else if ([key isEqualToString:@"isFinished"]) {
        [keyPaths addObject:@"completed"];
    }
    // make sure to return immutable copy
    return [NSSet setWithArray:[keyPaths allObjects]];
}

- (BOOL)isConcurrent
{
    return YES;
}

- (BOOL)isAsynchronous
{
    return YES;
}

- (BOOL)isExecuting
{
    return (self.running == YES) && (self.completed == NO);
}

- (BOOL)isFinished
{
    return self.completed;
}

/**
 Make sure all the subclassese call [super start];
 */
- (void)start
{
    self.running = YES;
}

- (void)finishWithResult:(id)aResult
{
    self.result = aResult;
    self.completed = YES;
}

- (void)failWithError:(NSError *)anError
{
    self.error = anError;
    self.completed = YES;
}

@end
