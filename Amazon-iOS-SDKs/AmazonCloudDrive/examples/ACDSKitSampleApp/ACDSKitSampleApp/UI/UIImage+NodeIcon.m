//
//  UIImage+NodeIcon.m
//  ACDSKitSampleApp
//
//  Copyright (c) 2015 Cloud Drive. All rights reserved.
//

#import "UIImage+NodeIcon.h"
#import <ACDSKit/ACDSKit.h>

@interface UIImage (NodeIconPrivate)

/**
 Dictionary of node content type strings to icon name postfix strings. Used as the ideal case when getting icons for file nodes.
 */
+ (NSDictionary *)nodeContentTypeToIconNamePostfixDictionary;

/**
 Dictionary of node file extension strings to icon name postfix strings. Used as a fallback when getting icons for file nodes.
 */
+ (NSDictionary *)nodeFileExtensionToIconNamePostfixDictionary;

/**
 Dictionary of node kind strings to icon name postfix strings. Used as a last resort when getting icons for nodes.
 */
+ (NSDictionary *)nodeKindToIconNamePostfixDictionary;

@end

@implementation UIImage (NodeIcon)

+ (UIImage *)iconForNode:(ACDSKNode *)node {
    
    NSString *iconNamePostfix = nil;
    
    NSString *kind = node.kind;
    
    // For files
    if ([kind isEqualToString:@"FILE"]) {
    
        // Ideal case - get icon name postfix from content type
        NSString *contentType = node.contentProperties.contentType;
        for (NSString *contentTypeKey in [self nodeContentTypeToIconNamePostfixDictionary]) {
            if ([contentType hasPrefix:contentTypeKey]) {
                iconNamePostfix = [self nodeContentTypeToIconNamePostfixDictionary][contentTypeKey];
                break;
            }
        }
        
        // Fallback - get icon name postfix from extension if we didn't get it already
        if (iconNamePostfix == nil) {
            NSString *fileExtension = node.contentProperties.fileExtension;
            iconNamePostfix = [self nodeFileExtensionToIconNamePostfixDictionary][fileExtension];
        }
        
    }
    
    // Last resort - get icon name postfix from node kind
    if (iconNamePostfix == nil) {
        iconNamePostfix = [self nodeKindToIconNamePostfixDictionary][kind];
    }
    
    UIImage *image = nil;
    if (iconNamePostfix != nil) {
        image = [UIImage imageNamed:[NSString stringWithFormat:@"icon-%@", iconNamePostfix]];
    }
    return image;
    
}

@end

@implementation UIImage (NodeIconPrivate)

/**
 Static dictionary of node content type strings to icon name postfix strings. Only allocated once.
 */
static NSDictionary *NodeContentTypeToIconNamePostfixDictionary;

+ (NSDictionary *)nodeContentTypeToIconNamePostfixDictionary {
    if (NodeContentTypeToIconNamePostfixDictionary == nil) {
        NodeContentTypeToIconNamePostfixDictionary =
        @{
          @"image/"                                                             : @"photo",
          @"audio/"                                                             : @"music",
          @"video/"                                                             : @"video",
          @"text/html"                                                          : @"html",
          @"text/"                                                              : @"text",
          @"application/pdf"                                                    : @"pdf",
          @"application/zip"                                                    : @"zip",
          @"application/msword"                                                 : @"word",
          @"application/vnd.ms-word"                                            : @"word",
          @"application/vnd.openxmlformats-officedocument.wordprocessingml"     : @"word",
          @"application/vnd.ms-excel"                                           : @"excel",
          @"application/vnd.openxmlformats-officedocument.spreadsheetml"        : @"excel",
          @"application/vnd.ms-powerpoint"                                      : @"powerpoint",
          @"application/vnd.openxmlformats-officedocument.presentationml"       : @"powerpoint",
          };
    }
    return NodeContentTypeToIconNamePostfixDictionary;
}

/**
 Static dictionary of node file extension strings to icon name postfix strings. Only allocated once.
 */
static NSDictionary *NodeFileExtensionToIconNamePostfixDictionary;

+ (NSDictionary *)nodeFileExtensionToIconNamePostfixDictionary {
    if (NodeFileExtensionToIconNamePostfixDictionary == nil) {
        NodeFileExtensionToIconNamePostfixDictionary =
        @{
          /* exe */
          @"exe"    : @"exe",
          /* music */
          @"aac"    : @"music",
          @"aif"    : @"music",
          @"aiff"   : @"music",
          @"au"     : @"music",
          @"flac"   : @"music",
          @"m4a"    : @"music",
          @"m4p"    : @"music",
          @"mp3"    : @"music",
          @"mpga"   : @"music",
          @"ogg"    : @"music",
          @"wav"    : @"music",
          @"wma"    : @"music",
          /* photo */
          @"3fr"    : @"photo",
          @"ari"    : @"photo",
          @"arw"    : @"photo",
          @"bay"    : @"photo",
          @"bmp"    : @"photo",
          @"cr2"    : @"photo",
          @"crw"    : @"photo",
          @"dcr"    : @"photo",
          @"dcs"    : @"photo",
          @"dng"    : @"photo",
          @"drf"    : @"photo",
          @"eip"    : @"photo",
          @"erf"    : @"photo",
          @"fff"    : @"photo",
          @"gif"    : @"photo",
          @"iiq"    : @"photo",
          @"jpeg"   : @"photo",
          @"jpg"    : @"photo",
          @"jps"    : @"photo",
          @"k25"    : @"photo",
          @"kdc"    : @"photo",
          @"mef"    : @"photo",
          @"mos"    : @"photo",
          @"mpo"    : @"photo",
          @"mrw"    : @"photo",
          @"nef"    : @"photo",
          @"nrw"    : @"photo",
          @"obm"    : @"photo",
          @"orf"    : @"photo",
          @"pef"    : @"photo",
          @"png"    : @"photo",
          @"pxn"    : @"photo",
          @"raf"    : @"photo",
          @"raw"    : @"photo",
          @"rw2"    : @"photo",
          @"rwl"    : @"photo",
          @"rwz"    : @"photo",
          @"sr2"    : @"photo",
          @"srf"    : @"photo",
          @"srw"    : @"photo",
          @"tif"    : @"photo",
          @"tiff"   : @"photo",
          @"x3f"    : @"photo",
          /* video */
          @"3g2"    : @"video",
          @"3gp"    : @"video",
          @"amzn"   : @"video",
          @"asf"    : @"video",
          @"avi"    : @"video",
          @"divx"   : @"video",
          @"dv"     : @"video",
          @"f4v"    : @"video",
          @"flv"    : @"video",
          @"m2t"    : @"video",
          @"m2ts"   : @"video",
          @"m4v"    : @"video",
          @"mkv"    : @"video",
          @"mod"    : @"video",
          @"mov"    : @"video",
          @"mp4"    : @"video",
          @"mpeg"   : @"video",
          @"mpg"    : @"video",
          @"mts"    : @"video",
          @"qt"     : @"video",
          @"r3d"    : @"video",
          @"rmvb"   : @"video",
          @"tivo"   : @"video",
          @"vob"    : @"video",
          @"webm"   : @"video",
          @"wmv"    : @"video"
          };
    }
    return NodeFileExtensionToIconNamePostfixDictionary;
}

/**
 Static dictionary of node kind strings to icon name postfix strings. Only allocated once.
 */
static NSDictionary *NodeKindToIconNamePostfixDictionary;

+ (NSDictionary *)nodeKindToIconNamePostfixDictionary {
    if (NodeKindToIconNamePostfixDictionary == nil) {
        NodeKindToIconNamePostfixDictionary =
        @{
          @"FOLDER"   : @"folder",
          @"FILE"     : @"file"
          };
    }
    return NodeKindToIconNamePostfixDictionary;
}

@end
