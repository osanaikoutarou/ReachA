//
//  ViewController.m
//  ACDSKitHelloWorld
//
//  Copyright (c) 2015 Cloud Drive. All rights reserved.
//

#import "ViewController.h"
#import "AMZNAccountManager.h"
#import <ACDSKit/ACDSKit.h>
#import "AMZNAuthorizationProvider.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextView *outputTextView;

@property (strong, nonatomic) ACDSKClient *client;

@property (strong, nonatomic) ACDSKTask *listNodesTask;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.outputTextView.text = @"";
}

- (IBAction)loginButtonPressed:(id)sender {
    [[AMZNAccountManager sharedProvider] loginAsynchronously:^(id result, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // Add to output
            if (error) {
                self.outputTextView.text = [self.outputTextView.text stringByAppendingFormat:@"login failure: %@\n", error];
            } else {
                self.outputTextView.text = [self.outputTextView.text stringByAppendingFormat:@"login success: %@\n", result];
            }
        });
    }];
}

- (IBAction)logoutButtonPressed:(id)sender {
    [[AMZNAccountManager sharedProvider] logoutAsynchronously:^(id result, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // Cancel the task
            [self.listNodesTask cancel];
            self.listNodesTask = nil;
            // Deallocate the client
            self.client = nil;
            // Add to output
            if (error) {
                self.outputTextView.text = [self.outputTextView.text stringByAppendingFormat:@"logout failure: %@\n", error];
            } else {
                self.outputTextView.text = [self.outputTextView.text stringByAppendingFormat:@"logout success: %@\n", result];
            }
        });
    }];
}

- (ACDSKClient *)client {
    if (_client == nil) {
        _client = [ACDSKClient clientWithTokenProvider:^NSString *{
            NSError *error = nil;
            return [[AMZNAuthorizationProvider sharedProvider] fetchAuthTokenSynchronously:&error];
        }];
    }
    return _client;
}

- (IBAction)listNodesButtonPressed:(id)sender {
    
    // Only allow one listNodesTask at a time
    if (self.listNodesTask == nil) {
        
        // Create a request to list nodes
        ACDSKListNodesRequest *listNodesRequest = [ACDSKListNodesRequest new];
        
        // Send the request, and keep a reference to the task
        self.listNodesTask = [self.client listNodes:listNodesRequest fail:^(NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                // Drop the reference to the task
                self.listNodesTask = nil;
                // Add to output
                self.outputTextView.text = [self.outputTextView.text stringByAppendingFormat:@"list nodes failure: %@\n", error];
            });
        } success:^(ACDSKListNodesResponse *response) {
            // Construct the output
            NSString *nodesDescription = @"";
            for (ACDSKNode *node in response.data) {
                nodesDescription = [nodesDescription stringByAppendingFormat:@"%@ (%@ - %@)\n", node.name, node.kind, node.contentProperties.contentType];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                // Drop the reference to the task
                self.listNodesTask = nil;
                // Add to output
                self.outputTextView.text = [self.outputTextView.text stringByAppendingFormat:@"list nodes success: %@ nodes:\n%@", @(response.data.count), nodesDescription];
            });
        }];
        
    }
    
}

@end
