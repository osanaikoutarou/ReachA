//
//  PreviewViewController.m
//  ACDSKitSampleApp
//
//  Copyright (c) 2015 Cloud Drive. All rights reserved.
//

#import "PreviewViewController.h"
#import "ACDSKClient+Convenience.h"
#import "AMZNAccountManager+Notification.h"

@interface PreviewViewController () <UIDocumentInteractionControllerDelegate>

///---------------------
/// @name Lifecycle
///---------------------

/**
 Called from all init methods. Chance to set up view controller.
 */
- (void)setup;

///---------------------
/// @name View lifecycle
///---------------------

/**
 Whether the view is visible. Set to YES at start of viewDidAppear and NO at start of viewDidDisappear.
 */
@property (nonatomic) BOOL isViewVisible;

///---------------------
/// @name Remote data
///---------------------

/**
 Task for downloading the file.
 */
@property (nonatomic, strong) ACDSKTask *downloadFileTask;

/**
 Downloads file for the given node. If successful, presents preview of file by calling showPreviewForFileLocation:.
 @param node Node for which the file should be downloaded.
 */
- (void)downloadFileForNode:(ACDSKNode *)node;

/**
 Progress of download. Used to update progress view.
 */
@property (nonatomic) CGFloat progress;

/**
 Progress bar that is updated as file is downloaded.
 */
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

/**
 Updates progress view for given progress.
 @param progress Progress value.
 */
- (void)updateViewsForProgress:(CGFloat)progress;

/**
 File path at which file was downloaded.
 */
@property (nonatomic, copy) NSString *downloadFileLocation;

/**
 Set to YES when download completes and failed. Set to NO when download copmletes and succeeds.
 */
@property (nonatomic) BOOL downloadFailed;

/**
 Reload button. Hidden unless download failed. Calls reloadButtonPressed: when pressed, which triggers download to start again.
 */
@property (weak, nonatomic) IBOutlet UIButton *reloadButton;

/**
 Triggers download to start again.
 @param sender The reload button that was pressed.
 */
- (IBAction)reloadButtonPressed:(UIButton *)sender;

/**
 Updates visibility of reload button according to download state. Reload button is only visible if downloadFileTask and downloadFileLocation are both nil and downloadFailed flag is YES.
 */
- (void)updateReloadButtonVisibility;

///---------------------
/// @name Preview
///---------------------

/**
 Shows preview of file at given location. Uses a document interaction controller.
 */
- (void)showPreviewForFileLocation:(NSString *)fileLocation;

/**
 Whether the presentation of the preview of the downloaded file has been initiated.
 */
@property (nonatomic) BOOL previewInitiated;

/**
 Whether the presentation of the preview of the downloaded file has been completed.
 */
@property (nonatomic) BOOL previewCompleted;

///---------------------
/// @name Logout
///---------------------

/**
 Notification callback when user logs out.
 */
- (void)didLogOut:(NSNotification *)notification;

@end

@implementation PreviewViewController

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
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Preview";
    [self updateViewsForProgress:self.progress];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.isViewVisible = YES;
    if (self.previewCompleted) {
        [self.navigationController popViewControllerAnimated:YES];
    } else if (self.downloadFileLocation) {
        [self showPreviewForFileLocation:self.downloadFileLocation];
    } else {
        [self downloadFileForNode:self.node];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.downloadFileTask cancel];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.isViewVisible = NO;
    if (self.previewInitiated) {
        self.previewCompleted = YES;
    }
}

#pragma mark - NodeViewController

- (void)updateForNode:(ACDSKNode *)node {
    [super updateForNode:node];
    [self downloadFileForNode:node];
}

- (NSString *)titleDefault {
    return @"Preview";
}

#pragma mark - Remote data

- (void)downloadFileForNode:(ACDSKNode *)node {
    if (self.downloadFileTask == nil && self.downloadFileLocation == nil) {
        
        self.progress = 0;
        ACDSKDownloadFileRequest *downloadFileRequest = [ACDSKDownloadFileRequest requestWithFileID:node.nodeId];
        NSString *contentType = node.contentProperties.contentType;
        if ([contentType hasPrefix:@"image/"]) {
            CGSize screenBoundsSize = [UIScreen mainScreen].bounds.size;
            CGFloat screenMaxDimension = MAX(screenBoundsSize.width, screenBoundsSize.height) * [UIScreen mainScreen].scale;
            downloadFileRequest.viewBox = screenMaxDimension;
        }
        self.downloadFileTask = [[ACDSKClient sharedInstance] downloadFile:downloadFileRequest fail:^(NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.downloadFileTask = nil;
                self.downloadFailed = YES;
                [self updateReloadButtonVisibility];
            });
        } progress:^(float progressed) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.progress = progressed;
            });
        } success:^(ACDSKDownloadFileResponse *response) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.downloadFileTask = nil;
                self.progress = 1.0;
                self.downloadFailed = NO;
                
                NSString *locationOrg = response.location;
                
                NSString *locationOrgWithoutExtension = [locationOrg stringByDeletingPathExtension];
                NSError *createDirectoryError = nil;
                [[NSFileManager defaultManager] createDirectoryAtPath:locationOrgWithoutExtension withIntermediateDirectories:NO attributes:nil error:&createDirectoryError];
                
                NSString *name = node.name;
                NSString *nameWithoutExtension = [name stringByDeletingPathExtension];
                NSString *nameWithExtension = [nameWithoutExtension stringByAppendingPathExtension:node.contentProperties.fileExtension];
                
                NSString *locationMod = [locationOrgWithoutExtension stringByAppendingPathComponent:nameWithExtension];
                
                NSError *moveItemError = nil;
                [[NSFileManager defaultManager] moveItemAtPath:locationOrg toPath:locationMod error:&moveItemError];
                
                self.downloadFileLocation = locationMod;
                
                [self updateReloadButtonVisibility];
                
                [self showPreviewForFileLocation:self.downloadFileLocation];
                
            });
        }];
        [self updateReloadButtonVisibility];
        
    }
}

- (void)setProgress:(CGFloat)progress {
    if (_progress != progress) {
        _progress = progress;
        if (self.isViewLoaded) {
            [self updateViewsForProgress:self.progress];
        }
    }
}

- (void)updateViewsForProgress:(CGFloat)progress {
    self.progressView.progress = progress;
}

- (IBAction)reloadButtonPressed:(UIButton *)sender {
    [self downloadFileForNode:self.node];
}

- (void)updateReloadButtonVisibility {
    self.reloadButton.hidden = !(self.downloadFailed && self.downloadFileTask == nil && self.downloadFileLocation == nil);
}

#pragma mark - Preview

- (void)showPreviewForFileLocation:(NSString *)fileLocation {
    if (self.isViewVisible && !self.previewInitiated) {
        UIDocumentInteractionController *documentInteractionControler = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:fileLocation]];
        documentInteractionControler.name = self.node.name;
        documentInteractionControler.delegate = self;
        BOOL presentPreviewSuccess = [documentInteractionControler presentPreviewAnimated:YES];
        if (presentPreviewSuccess) {
            self.previewInitiated = YES;
        } else {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Unable to preview" message:[NSString stringWithFormat:@"Unable to preview file with content type '%@' and extension '%@' on this device.", self.node.contentProperties.contentType, self.node.contentProperties.fileExtension] preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                [self.navigationController popViewControllerAnimated:YES];
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }
}

#pragma mark - UIDocumentInteractionControllerDelegate

- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller {
    return self;
}

#pragma mark - Logout

- (void)didLogOut:(NSNotification *)notification {
    [self.downloadFileTask cancel];
    self.downloadFileTask = nil;
    
}

@end
