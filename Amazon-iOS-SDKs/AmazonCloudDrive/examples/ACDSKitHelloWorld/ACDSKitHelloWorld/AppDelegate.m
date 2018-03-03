//
//  AppDelegate.m
//  ACDSKitHelloWorld
//
//  Copyright (c) 2015 Cloud Drive. All rights reserved.
//

#import "AppDelegate.h"
#import <LoginWithAmazon/LoginWithAmazon.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark - Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

#pragma mark - Open URL

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    // Pass on the url to the SDK to parse authorization code from the url.
    BOOL isValidRedirectLogInURL = [AIMobileLib handleOpenURL:url sourceApplication:sourceApplication];
    
    if(!isValidRedirectLogInURL)
        return NO;
    
    // App may also want to handle url
    return YES;
    
}

@end
