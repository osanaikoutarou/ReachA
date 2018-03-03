//
//  ListViewController.m
//  ACDSKitSampleApp
//
//  Copyright (c) 2015 Cloud Drive. All rights reserved.
//

#import "ListViewController.h"
#import "ACDSKClient+Convenience.h"
#import "UIImage+NodeIcon.h"
#import "AMZNAccountManager.h"
#import "AMZNAccountManager+Notification.h"

/**
 Cell reuse identifier for general node cells.
 */
static NSString * const kListCellReuseIdentifierGeneral = @"GeneralNodeCell";

/**
 Cell reuse identifier for folder node cells.
 */
static NSString * const kListCellReuseIdentifierFolder = @"FolderNodeCell";

/**
 Cell reuse identifier for file node cells.
 */
static NSString * const kListCellReuseIdentifierFile = @"FileNodeCell";

/**
 Title for alert for error getting data.
 */
static NSString * const kListAlertTitleErrorGettingData = @"Error Getting Data";

/**
 Title for alert for error deleting item.
 */
static NSString * const kListAlertTitleErrorDeleting = @"Error Deleting Item";

/**
 User default key used for persisting sort order preference across app launches.
 */
static NSString * const kListSortOrderDefaultUserDefaultsKey = @"kListSortOrderDefaultUserDefaultsKey";

/**
 Default sort order for a list.
 */
const ListViewControllerSortOrder kListViewControllerSortOrderDefault = ListViewControllerSortOrderModifiedDateDesc;

/**
 Controls the point at which more children are loaded from the server. When table view is scrolled within this many multiples of the table view height, more children are loaded. Should be greater than or equal to 1.0.
 */
const CGFloat kListGetMoreChildrenScrollTriggerMultipleOfBoundsHeight = 2.0;

@interface ListViewController () <UITableViewDelegate, UITableViewDataSource>

///---------------------
/// @name Lifecycle
///---------------------

/**
 Called from all init methods. Chance to set up view controller.
 */
- (void)setup;

///---------------------
/// @name Remote data
///---------------------

/**
 Task for getting root node.
 */
@property (nonatomic, strong) ACDSKTask *getRootTask;

/**
 Task for getting first page of children.
 */
@property (nonatomic, strong) ACDSKTask *getSomeChildrenTask;

/**
 Task for getting subsequent pages of children.
 */
@property (nonatomic, strong) ACDSKTask *getMoreChildrenTask;

/**
 Gets children of given node or else gets root node if node is nil.
 @param node Node for which data should be retrieved. If nil, prompts getting root node.
 */
- (void)getDataForNode:(ACDSKNode *)node;

/**
 Gets root node and sets it as the focal node of the list.
 */
- (void)getDataForRootNode;

/**
 Gets children of given node starting with given start token.
 @param node Node for which children should be retrieved.
 @param startToken Token for page of children to retrieve.
 */
- (void)getDataForParentNode:(ACDSKNode *)node startToken:(NSString *)startToken;

///---------------------
/// @name Local data
///---------------------

/**
 Array of child nodes to display.
 */
@property (nonatomic, strong) NSMutableArray *data;

/**
 Token for next page of children, if any.
 */
@property (nonatomic, strong) NSString *nextToken;

/**
 Returns whether local data exists.
 @return Whether local data exists.
 */
- (BOOL)hasData;

/**
 Returns node for given index path, if one exists.
 @param indexPath Index path of node.
 @return Node for given index path.
 */
- (ACDSKNode *)nodeForIndexPath:(NSIndexPath *)indexPath;

/**
 Returns index path of node with given node ID, if it exists in local data.
 @param nodeID Node ID of node.
 @return Index path of node.
 */
- (NSIndexPath *)indexPathForNodeWithID:(NSString *)nodeID;

///---------------------
/// @name Table view
///---------------------

/**
 Reloads table view with current local data. Toggles visibility of empty view tableViewEmptyViewLabel depending on whether local data exists.
 */
- (void)reloadTableView;

/**
 The table view that displays the list of child nodes.
 */
@property (weak, nonatomic) IBOutlet UITableView *tableView;

/**
 The view that is displayed when local data does not exist.
 */
@property (nonatomic, strong) UILabel *tableViewEmptyViewLabel;

/**
 Updates empty view tableViewEmptyViewLabel text according to whether remote data load is in progress.
 */
- (void)updateTableViewEmptyViewLabel;

/**
 The pull to refresh control for the table view.
 */
@property (nonatomic, strong) UIRefreshControl *refreshControl;

/**
 Called when the refresh control is pulled.
 @param refreshControl The refresh control that was pulled.
 */
- (void)refreshControlPulled:(UIRefreshControl *)refreshControl;

///---------------------
/// @name Move to trash
///---------------------

/**
 Attempts to move node with given node ID to Cloud Drive trash, and if successful removes the corresponding row from the table view.
 @param nodeID Node ID of the node to move to trash.
 */
- (void)moveToTrashNodeWithID:(NSString *)nodeID;

/**
 Task for moving node to trash.
 */
@property (nonatomic, strong) ACDSKTask *moveToTrashTask;

///---------------------
/// @name Sort
///---------------------

/**
 Called when the sort button is pressed. Presents sort options to the user in the form of an alert. If there is already an alert visible, this method does nothing.
 @param sender The sort button that was pressed.
 */
- (IBAction)sortButtonPressed:(UIBarButtonItem *)sender;

/**
 Returns sort string that can be used with remote data request for given sort order.
 @param sortOrder Sort order option.
 @return Sort string that can be used with remote data request.
 */
- (NSString *)requestSortStringForSortOrder:(ListViewControllerSortOrder)sortOrder;

///---------------------
/// @name Logout
///---------------------

/**
 The logout button that is set as the left bar button item when the view controller is the root of the navigation stack. Calls logoutButtonPressed: when pressed.
 */
@property (weak, nonatomic) IBOutlet UIBarButtonItem *logOutButton;

/**
 Called when the logout logout button is pressed. Uses AMZNAccountManager to log out asynchronously, and if successful posts a AMZNAccountManagerDidLogOutNotification notification on the main thread.
 @param sender The logout button that was pressed.
 */
- (IBAction)logoutButtonPressed:(UIBarButtonItem *)sender;

/**
 Notification callback when user logs out.
 */
- (void)didLogOut:(NSNotification *)notification;

///---------------------
/// @name Alerts
///---------------------

/**
 Shows an alert with the given title and message from the given error. Optionally includes a retry option. If there is already an alert visible, this method does nothing.
 @param title Title of the alert.
 @param error Error that prompted the alert. Description used for the alert message.
 @param retryHandler Optional block to execute if the user chooses to retry. If nil, no retry option is offered.
 */
- (void)showAlertControllerWithTitle:(NSString *)title forError:(NSError *)error withRetryHandler:(void(^)(UIAlertAction *action))retryHandler;

/**
 The current alert controller.
 */
@property (nonatomic, strong) UIAlertController *alertController;

@end

@implementation ListViewController

#pragma mark - Lifecycle

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didLogOut:) name:AMZNAccountManagerDidLogOutNotification object:nil];
    ListViewControllerSortOrder sortOrder = [[NSUserDefaults standardUserDefaults] integerForKey:kListSortOrderDefaultUserDefaultsKey];
    if (sortOrder == ListViewControllerSortOrderNone) {
        [[NSUserDefaults standardUserDefaults] setInteger:kListViewControllerSortOrderDefault forKey:kListSortOrderDefaultUserDefaultsKey];
        sortOrder = kListViewControllerSortOrderDefault;
    }
    self.sortOrder = sortOrder;
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshControlPulled:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    
    [self reloadTableView];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView deselectRowAtIndexPath:self.tableView.indexPathForSelectedRow animated:YES];
    self.navigationItem.leftBarButtonItem = self == self.navigationController.viewControllers.firstObject ? self.logOutButton : nil;
}

#pragma mark - NodeViewController

- (void)updateForNode:(ACDSKNode *)node {
    [super updateForNode:node];
    [self getDataForNode:node];
}

- (NSString *)titleDefault {
    return @"Cloud Drive";
}

#pragma mark - Remote data

- (void)getDataForNode:(ACDSKNode *)node {
    if (!node) {
        [self getDataForRootNode];
    } else {
        [self getDataForParentNode:node startToken:nil];
    }
}

- (void)getDataForRootNode {
    if (self.getRootTask == nil) {
        
        [self.getSomeChildrenTask cancel];
        self.getSomeChildrenTask = nil;
        [self.getMoreChildrenTask cancel];
        self.getMoreChildrenTask = nil;
        
        [self.refreshControl beginRefreshing];
        self.getRootTask = [[ACDSKClient sharedInstance] listRootNode:^(NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.getRootTask = nil;
                [self showAlertControllerWithTitle:kListAlertTitleErrorGettingData forError:error withRetryHandler:^(UIAlertAction *action) {
                    [self getDataForRootNode];
                }];
                [self.refreshControl endRefreshing];
                [self updateTableViewEmptyViewLabel];
            });
        } success:^(ACDSKListNodesResponse *response) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.getRootTask = nil;
                ACDSKNode *rootNode = response.data.firstObject;
                self.node = rootNode;
                [self.refreshControl endRefreshing];
                [self updateTableViewEmptyViewLabel];
            });
        }];
        [self updateTableViewEmptyViewLabel];
        
    }
}

- (void)getDataForParentNode:(ACDSKNode *)node startToken:(NSString *)startToken {
    
    if (self.getRootTask == nil) {
        
        BOOL isGetMoreTask = startToken != nil;
        
        if ((!isGetMoreTask && self.getSomeChildrenTask == nil) ||
            ( isGetMoreTask && self.getMoreChildrenTask == nil)) {
            
            if (!isGetMoreTask) {
                [self.getMoreChildrenTask cancel];
                self.getMoreChildrenTask = nil;
            }
            
            ACDSKListChildrenRequest *getChildrenRequest = [ACDSKListChildrenRequest new];
            getChildrenRequest.parentID = node.nodeId;
            NSString *getChildrenRequestSortString = [self requestSortStringForSortOrder:self.sortOrder];
            getChildrenRequest.sort = getChildrenRequestSortString;
            if (isGetMoreTask) {
                getChildrenRequest.startToken = startToken;
            }
            
            [self.refreshControl beginRefreshing];
            ACDSKTask *getChildrenTask = [[ACDSKClient sharedInstance] listChildren:getChildrenRequest fail:^(NSError *error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.getSomeChildrenTask = nil;
                    self.getMoreChildrenTask = nil;
                    [self showAlertControllerWithTitle:kListAlertTitleErrorGettingData forError:error withRetryHandler:^(UIAlertAction *action) {
                        [self getDataForParentNode:node startToken:startToken];
                    }];
                    [self.refreshControl endRefreshing];
                    [self updateTableViewEmptyViewLabel];
                });
            } success:^(ACDSKListChildrenResponse *response) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.getSomeChildrenTask = nil;
                    self.getMoreChildrenTask = nil;
                    if (!isGetMoreTask) {
                        self.data = [response.data mutableCopy];
                    } else {
                        [self.data addObjectsFromArray:response.data];
                    }
                    self.nextToken = response.nextToken;
                    [self reloadTableView];
                    [self.refreshControl endRefreshing];
                });
            }];
            if (isGetMoreTask) {
                self.getMoreChildrenTask = getChildrenTask;
            } else {
                self.getSomeChildrenTask = getChildrenTask;
            }
            [self updateTableViewEmptyViewLabel];
            
        }
        
    }
    
}

#pragma mark - Local data

- (BOOL)hasData {
    return self.data.count > 0;
}

- (ACDSKNode *)nodeForIndexPath:(NSIndexPath *)indexPath {
    ACDSKNode *node = nil;
    if (indexPath.row < self.data.count) {
        node = self.data[indexPath.row];
    }
    return node;
}

- (NSIndexPath *)indexPathForNodeWithID:(NSString *)nodeID {
    NSIndexPath *indexPath = nil;
    NSUInteger index = [self.data indexOfObjectPassingTest:^BOOL(ACDSKNode *node, NSUInteger idx, BOOL *stop) {
        return [node.nodeId isEqualToString:nodeID];
    }];
    if (index != NSNotFound) {
        indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    }
    return indexPath;
}

#pragma mark - Table view

- (void)reloadTableView {
    if (self.isViewLoaded) {
        BOOL hasData = [self hasData];
        UITableViewCellSeparatorStyle tableViewCellSeparatorStyle = UITableViewCellSeparatorStyleSingleLine;
        UIView *tableViewBackgroundView = nil;
        if (!hasData) {
            tableViewCellSeparatorStyle = UITableViewCellSeparatorStyleNone;
            [self updateTableViewEmptyViewLabel];
            tableViewBackgroundView = self.tableViewEmptyViewLabel;
        }
        self.tableView.separatorStyle = tableViewCellSeparatorStyle;
        self.tableView.backgroundView = tableViewBackgroundView;
        [self.tableView reloadData];
    }
}

- (UILabel *)tableViewEmptyViewLabel {
    if (_tableViewEmptyViewLabel == nil) {
        _tableViewEmptyViewLabel = [[UILabel alloc] init];
        _tableViewEmptyViewLabel.textColor = [UIColor blackColor];
        _tableViewEmptyViewLabel.numberOfLines = 0;
        _tableViewEmptyViewLabel.textAlignment = NSTextAlignmentCenter;
        _tableViewEmptyViewLabel.font = [UIFont italicSystemFontOfSize:18];
    }
    return _tableViewEmptyViewLabel;
}

- (void)updateTableViewEmptyViewLabel {
    NSString *tableViewEmptyViewLabelText = @"No data is currently available.\nPull down to refresh.";
    if (self.getRootTask != nil ||
        self.getSomeChildrenTask != nil) {
        tableViewEmptyViewLabelText = @"Loading data...";
    }
    self.tableViewEmptyViewLabel.text = tableViewEmptyViewLabelText;
}

- (void)refreshControlPulled:(UIRefreshControl *)refreshControl {
    [self getDataForNode:self.node];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger numberOfSections = [self hasData] ? 1 : 0;
    return numberOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger numberOfRows = [self hasData] ? self.data.count : 0;
    return numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ACDSKNode *node = [self nodeForIndexPath:indexPath];
    
    NSString *cellReuseIdentifier = kListCellReuseIdentifierGeneral;
    if ([node.kind isEqualToString:@"FOLDER"]) {
        cellReuseIdentifier = kListCellReuseIdentifierFolder;
    } else if ([node.kind isEqualToString:@"FILE"]) {
        cellReuseIdentifier = kListCellReuseIdentifierFile;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier forIndexPath:indexPath];
    cell.textLabel.text = node.name;
    cell.imageView.image = [UIImage iconForNode:node];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        ACDSKNode *node = [self nodeForIndexPath:indexPath];
        [self moveToTrashNodeWithID:node.nodeId];
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.node && self.nextToken && [self hasData] && scrollView.contentOffset.y >= scrollView.contentSize.height - (scrollView.bounds.size.height * kListGetMoreChildrenScrollTriggerMultipleOfBoundsHeight)) {
        [self getDataForParentNode:self.node startToken:self.nextToken];
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    id destinationViewController = [segue destinationViewController];
    if ([destinationViewController isKindOfClass:[NodeViewController class]]) {
        
        NodeViewController *nodeViewController = destinationViewController;
        if ([nodeViewController isKindOfClass:[ListViewController class]]) {
            ListViewController *listViewController = (ListViewController *)nodeViewController;
            listViewController.sortOrder = self.sortOrder;
        }
        ACDSKNode *selectedNode = [self nodeForIndexPath:self.tableView.indexPathForSelectedRow];
        nodeViewController.node = selectedNode;
        
    }
    
}

#pragma mark - Move to trash

- (void)moveToTrashNodeWithID:(NSString *)nodeID {
    ACDSKMoveNodeToTrashRequest *moveNodeToTrashRequest = [ACDSKMoveNodeToTrashRequest new];
    moveNodeToTrashRequest.nodeID = nodeID;
    self.moveToTrashTask = [[ACDSKClient sharedInstance] moveNodeToTrash:moveNodeToTrashRequest fail:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.moveToTrashTask = nil;
            [self showAlertControllerWithTitle:kListAlertTitleErrorDeleting forError:error withRetryHandler:^(UIAlertAction *action) {
                [self moveToTrashNodeWithID:nodeID];
            }];
        });
    } success:^(ACDSKMoveNodeToTrashResponse *response) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.moveToTrashTask = nil;
            NSIndexPath *indexPath = [self indexPathForNodeWithID:nodeID];
            if (indexPath) {
                if (indexPath.row < self.data.count) {
                    [self.data removeObjectAtIndex:indexPath.row];
                }
                [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            }
        });
    }];
}

#pragma mark - Sort

- (NSString *)requestSortStringForSortOrder:(ListViewControllerSortOrder)sortOrder {
    
    NSString *key = nil;
    switch (sortOrder) {
        case ListViewControllerSortOrderNameAsc:
        case ListViewControllerSortOrderNameDesc:
            key = @"name";
            break;
        case ListViewControllerSortOrderModifiedDateAsc:
        case ListViewControllerSortOrderModifiedDateDesc:
            key = @"modifiedDate";
            break;
        default:
            break;
    }
    
    NSString *order = nil;
    switch (sortOrder) {
        case ListViewControllerSortOrderNameAsc:
        case ListViewControllerSortOrderModifiedDateAsc:
            order = @"ASC";
            break;
        case ListViewControllerSortOrderNameDesc:
        case ListViewControllerSortOrderModifiedDateDesc:
            order = @"DESC";
            break;
        default:
            break;
    }
    
    NSString *sortString = nil;
    if (key != nil && order != nil) {
        sortString = [NSString stringWithFormat:@"[\"%@ %@\"]", key, order];
    }
    return sortString;
    
}

- (IBAction)sortButtonPressed:(UIBarButtonItem *)sender {
    
    if (self.alertController == nil) {
        
        self.alertController = [UIAlertController alertControllerWithTitle:@"Sort Files" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        void(^addSortAction)(NSString *, ListViewControllerSortOrder) = ^(NSString *title, ListViewControllerSortOrder sortOrder) {
            UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                self.sortOrder = sortOrder;
                [[NSUserDefaults standardUserDefaults] setInteger:sortOrder forKey:kListSortOrderDefaultUserDefaultsKey];
                [self getDataForNode:self.node];
                self.alertController = nil;
            }];
            action.enabled = self.sortOrder != sortOrder;
            [self.alertController addAction:action];
        };
        addSortAction(@"A -> Z", ListViewControllerSortOrderNameAsc);
        addSortAction(@"Z -> A", ListViewControllerSortOrderNameDesc);
        addSortAction(@"Most Recent", ListViewControllerSortOrderModifiedDateDesc);
        addSortAction(@"Oldest", ListViewControllerSortOrderModifiedDateAsc);
        [self.alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            self.alertController = nil;
        }]];
        
        [self presentViewController:self.alertController animated:YES completion:nil];
        
    }
    
}

#pragma mark - Logout

- (IBAction)logoutButtonPressed:(UIBarButtonItem *)sender {
    [[AMZNAccountManager sharedProvider] logoutAsynchronously:^(id result, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSUserDefaults standardUserDefaults] setInteger:kListViewControllerSortOrderDefault forKey:kListSortOrderDefaultUserDefaultsKey];
            [[NSNotificationCenter defaultCenter] postNotificationName:AMZNAccountManagerDidLogOutNotification object:self];
        });
    }];
}

- (void)didLogOut:(NSNotification *)notification {
    [self.getRootTask cancel];
    [self.getSomeChildrenTask cancel];
    [self.getMoreChildrenTask cancel];
    [self.moveToTrashTask cancel];
    self.getRootTask = nil;
    self.getSomeChildrenTask = nil;
    self.getMoreChildrenTask = nil;
    self.moveToTrashTask = nil;
}

#pragma mark - Alerts

- (void)showAlertControllerWithTitle:(NSString *)title forError:(NSError *)error withRetryHandler:(void(^)(UIAlertAction *action))retryHandler {
    if (self.alertController == nil && self.isViewLoaded && self.view.window) {
        self.alertController = [UIAlertController alertControllerWithTitle:@"Error Getting Data" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
        dispatch_block_t completion = ^{
            self.alertController = nil;
        };
        if (retryHandler) {
            [self.alertController addAction:[UIAlertAction actionWithTitle:@"Retry" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                retryHandler(action);
                completion();
            }]];
        }
        [self.alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            completion();
        }]];
        [self presentViewController:self.alertController animated:YES completion:nil];
    }
}

@end
