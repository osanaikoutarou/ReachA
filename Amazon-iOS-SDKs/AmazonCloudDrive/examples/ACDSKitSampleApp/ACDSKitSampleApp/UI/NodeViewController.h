//
//  NodeViewController.h
//  ACDSKitSampleApp
//
//  Copyright (c) 2015 Cloud Drive. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ACDSKNode;

/**
 NodeViewController is intended to be an abstract class for any view controller whose model is based in a single node. When its node is set, it updates its model and views accordingly.
 */
@interface NodeViewController : UIViewController

///---------------------
/// @name Node
///---------------------

/**
 The focal node of the view controller. When set to a new node, calls updateForNode: to update model and views accordingly.
 */
@property (nonatomic, strong) ACDSKNode *node;

/**
 Called when node is set to a new node. Chance to update model and views accordingly. Subclasses can override. Should call super.
 @param node Node that should be used as the base for model and view updates.
 */
- (void)updateForNode:(ACDSKNode *)node;

///---------------------
/// @name Title
///---------------------

/**
 Returns the default title for the view controller if no focal node is set.
 @return Default title for the view controller if no focal node is set.
 */
- (NSString *)titleDefault;

@end
