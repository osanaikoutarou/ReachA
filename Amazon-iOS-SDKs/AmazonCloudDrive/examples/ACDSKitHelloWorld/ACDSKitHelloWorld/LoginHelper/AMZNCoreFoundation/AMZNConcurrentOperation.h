//
//  AMZNConcurrentOperation.h
//  CloudDrivePhotosiOS
//
//  Copyright (c) 2014 Cloud Drive. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AMZNConcurrentOperation : NSOperation

@property (nonatomic, readonly) id result;
@property (nonatomic, readonly) NSError *error;

- (void)finishWithResult:(id)aResult;
- (void)failWithError:(NSError *)anError;

@end
