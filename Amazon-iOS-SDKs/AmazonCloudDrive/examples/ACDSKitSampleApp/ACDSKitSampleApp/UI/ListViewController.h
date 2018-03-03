//
//  ListViewController.h
//  ACDSKitSampleApp
//
//  Copyright (c) 2015 Cloud Drive. All rights reserved.
//

#import "NodeViewController.h"

/**
 Sort order options.
 */
typedef NS_ENUM(NSInteger, ListViewControllerSortOrder) {
    /**
     No sort order.
     */
    ListViewControllerSortOrderNone,
    /**
     Sort by name ascending (A -> Z).
     */
    ListViewControllerSortOrderNameAsc,
    /**
     Sort by name descending (Z -> A).
     */
    ListViewControllerSortOrderNameDesc,
    /**
     Sort by modified date ascending (oldest first).
     */
    ListViewControllerSortOrderModifiedDateAsc,
    /**
     Sort by modified date descending (most recent first).
     */
    ListViewControllerSortOrderModifiedDateDesc,
};

/**
 Default sort order for a list.
 */
extern const ListViewControllerSortOrder kListViewControllerSortOrderDefault;

/**
 ListViewController is a table view based view controller that displays a list of children of a given parent node. If no parent node is specified, displays children of the root node. The list supports switching between various sort orders as well as swipe to delete.
 */
@interface ListViewController : NodeViewController

///---------------------
/// @name Sort
///---------------------

/**
 The sort order for the list. Defaults to kListViewControllerSortOrderDefault. Sort order preference is passed on to child list view controllers, persisted across app launches (using user defaults), and reset to default on user logout.
 */
@property (nonatomic) ListViewControllerSortOrder sortOrder;

@end
