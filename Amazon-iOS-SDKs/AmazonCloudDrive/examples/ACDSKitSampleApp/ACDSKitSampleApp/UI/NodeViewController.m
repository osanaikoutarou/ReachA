//
//  NodeViewController.m
//  ACDSKitSampleApp
//
//  Copyright (c) 2015 Cloud Drive. All rights reserved.
//

#import "NodeViewController.h"
#import <ACDSKit/ACDSKit.h>

@interface NodeViewController ()

///---------------------
/// @name Title
///---------------------

/**
 Updates the title of the view controller for the given node name. If nodeName is nil, uses the titleDefault for the view controller.
 @param nodeName Name of the node.
 */
- (void)updateTitleForNodeName:(NSString *)nodeName;

@end

@implementation NodeViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateForNode:self.node];
}

#pragma mark - Node

- (void)setNode:(ACDSKNode *)node {
    if (_node != node) {
        _node = node;
        [self updateForNode:self.node];
    }
}

- (void)updateForNode:(ACDSKNode *)node {
    [self updateTitleForNodeName:node.name];
}

#pragma mark - Title

- (void)updateTitleForNodeName:(NSString *)nodeName {
    NSString *title = nodeName ? nodeName : [self titleDefault];
    self.title = title;
}

- (NSString *)titleDefault {
    return @"Node";
}

@end
