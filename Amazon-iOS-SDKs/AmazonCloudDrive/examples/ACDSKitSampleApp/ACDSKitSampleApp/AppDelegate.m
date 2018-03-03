//
//  AppDelegate.m
//  ACDSKitSampleApp
//
//  Copyright (c) 2015 Cloud Drive. All rights reserved.
//

#import "AppDelegate.h"
#import <LoginWithAmazon/LoginWithAmazon.h>
#import "AMZNAuthorizationProvider.h"
#import "AMZNAccountManager+Notification.h"
#import "LoginViewController.h"
#import "ACDSKClient+Convenience.h"
#import "AMZNLoginWithAmazonError.h"

/**
 Authentication status of the user.
 */
typedef NS_ENUM(NSUInteger, AuthStatus) {
    /**
     Unknown authentication status.
     */
    AuthStatusUnknown,
    /**
     Logged in authentication status.
     */
    AuthStatusLoggedIn,
    /**
     Logged out authentication status.
     */
    AuthStatusLoggedOut,
};

@interface AppDelegate ()

///---------------------
/// @name Authentication
///---------------------

/**
 Updates root navigation controller if necessary according to given auth status. If user is logged in and login is visible, switches to main app. If user is not logged in and login is not visible, switches to login.
 @param authStatus Auth status to use in determining view controller. If authStatus is equalt to AuthStatusUnknown, attempts to determine authStatus.
 */
- (void)updateViewControllersForAuthStatus:(AuthStatus)authStatus;

/**
 Notification callback when user logs in. Calls updateViewControllersForAuthStatus:
 */
- (void)didLogIn:(NSNotification *)notification;

/**
 Notification callback when user logs out. Calls updateViewControllersForAuthStatus:
 */
- (void)didLogOut:(NSNotification *)notification;

@end

@implementation AppDelegate

#pragma mark - Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self updateViewControllersForAuthStatus:AuthStatusUnknown];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didLogIn:) name:AMZNAccountManagerDidLogInNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didLogOut:) name:AMZNAccountManagerDidLogOutNotification object:nil];
    return YES;
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [self updateViewControllersForAuthStatus:AuthStatusUnknown];
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

#pragma mark - Authentication

- (void)updateViewControllersForAuthStatus:(AuthStatus)authStatus {
    
    if (authStatus == AuthStatusUnknown) {
        
        [[AMZNAuthorizationProvider sharedProvider] fetchAuthTokenAsynchronously:^(id result, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                AuthStatus authStatusFetched = AuthStatusLoggedOut;
                if (error) {
                    // Error occurred while fetching auth token. For more information on potential LoginWithAmazon errors, see <LoginWithAmazon/AIError.h> and <LoginWithAmazon/AIMobileLib.h>
                    if ([error.domain isEqualToString:AMZNLoginWithAmazonErrorDomain] && error.code == kAIApplicationNotAuthorized) {
                        // Error occurred because a valid refresh token was not found. Status should be logged out.
                        authStatusFetched = AuthStatusLoggedOut;
                    } else {
                        // Error occurred, but not because a valid refresh token was not found. Status should be logged in, but should show error alert view.
                        authStatusFetched = AuthStatusLoggedIn;
                        UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error Occurred" message:error.userInfo[NSLocalizedDescriptionKey] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        [errorAlertView show];
                    }
                } else {
                    // No error occurred while fetching auth token. Status should be logged in so long as auth token is not empty.
                    NSString *authToken = result;
                    if (authToken.length > 0) {
                        authStatusFetched = AuthStatusLoggedIn;
                    }
                }
                [self updateViewControllersForAuthStatus:authStatusFetched];
            });
        }];
        
    } else {
        
        UINavigationController *mainNavigationController = (UINavigationController *)self.window.rootViewController;
        BOOL isLoginVisible = [mainNavigationController.viewControllers.firstObject isKindOfClass:[LoginViewController class]];
        
        if ((authStatus != AuthStatusLoggedIn && !isLoginVisible) ||
            (authStatus == AuthStatusLoggedIn &&  isLoginVisible)) {
            
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            NSString *viewControllerIdentifier = @"LoginViewController";
            if (authStatus == AuthStatusLoggedIn) {
                viewControllerIdentifier = @"ListViewController";
            }
            UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:viewControllerIdentifier];
            mainNavigationController.viewControllers = @[viewController];
            
        }
        
    }
    
}

- (void)didLogIn:(NSNotification *)notification {
    [self updateViewControllersForAuthStatus:AuthStatusLoggedIn];
}

- (void)didLogOut:(NSNotification *)notification {
    [ACDSKClient resetSharedInstance];
    [self updateViewControllersForAuthStatus:AuthStatusLoggedOut];
}

@end
