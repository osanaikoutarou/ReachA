//
//  UIImage+NodeIcon.h
//  ACDSKitSampleApp
//
//  Copyright (c) 2015 Cloud Drive. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ACDSKNode;

@interface UIImage (NodeIcon)

/**
 Returns icon image for given node, if one exists. Takes into account kind of node, content type, and file extension.
 @param node Node to analyze.
 @return Icon image.
 */
+ (UIImage *)iconForNode:(ACDSKNode *)node;

@end
