//
//  LoginViewController.h
//  ACDSKitSampleApp
//
//  Copyright (c) 2015 Cloud Drive. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 LoginViewController is the simplest possible view controller enabling user login. When its login button is pressed, it uses AMZNAccountManager to log in asynchronously, and if successful posts a AMZNAccountManagerDidLogInNotification notification on the main thread. It does not control any view controller navigation on its own. It is up to another class to respond to the notification.
 */
@interface LoginViewController : UIViewController

@end
