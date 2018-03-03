//
//  AMZNLoginWithAmazonConstants.h
//  TestApp
//
//  Copyright (c) 2015 Cloud Drive. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kAMZNCloudDriveAccessTokenProfileScope @"profile"
#define kAMZNCloudDriveAccessTokenReadScope @"clouddrive:read"
#define kAMZNCloudDriveAccessTokenWriteScope @"clouddrive:write"

#define kAMZNCloudDriveAccessTokenAllScope @[kAMZNCloudDriveAccessTokenProfileScope, kAMZNCloudDriveAccessTokenReadScope, kAMZNCloudDriveAccessTokenWriteScope]

#define kAMZNCloudDriveAccessTokenActiveScope kAMZNCloudDriveAccessTokenAllScope