//
//  LoginViewController.m
//  ACDSKitSampleApp
//
//  Copyright (c) 2015 Cloud Drive. All rights reserved.
//

#import "LoginViewController.h"
#import "AMZNAccountManager.h"
#import "ACDSKClient+Convenience.h"
#import "AMZNAccountManager+Notification.h"

@interface LoginViewController ()

///---------------------
/// @name Actions
///---------------------

/**
 The login button. Calls loginButtonPressed: when pressed.
 */
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

/**
 Called when the login button is pressed. Uses AMZNAccountManager to log in asynchronously, and if successful posts a AMZNAccountManagerDidLogInNotification notification on the main thread.
 @param sender The login button that was pressed.
 */
- (IBAction)loginButtonPressed:(UIButton *)sender;

@end

@implementation LoginViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Cloud Drive";
}

#pragma mark - Actions

- (IBAction)loginButtonPressed:(UIButton *)sender {
    [[AMZNAccountManager sharedProvider] loginAsynchronously:^(id result, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error Logging In" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
                [self showViewController:alertController sender:sender];
            } else {
                [[NSNotificationCenter defaultCenter] postNotificationName:AMZNAccountManagerDidLogInNotification object:self];
            }
        });
    }];
}

@end
