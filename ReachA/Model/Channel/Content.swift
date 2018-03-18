//
//  Content.swift
//  ReachA
//
//  Created by 長内幸太郎 on 2018/02/05.
//  Copyright © 2018年 osanai. All rights reserved.
//

import Foundation

class Content : Channel {
    var url:String? = ""
    var title:String? = ""
    var date:Date? = nil
}

// アニメ
class Anime : Content {
}

// comic
class Comic : Content {
}

// web comic
class WebComic : Content {
}

// 音楽
class Music : Content {
}

// 映像
class Video : Content {
}

// イベント
class Event : Content {
}

// キャラクター
class Caractor : Content {
}

///////////////////////// Media

class YoutubeVideo : Video {
    var youtubeId:String? = ""
}

class FanArt : Content {
    enum SourceType {
        case Twitter
    }
    enum MediaType {
        case Image
        case ImageSet
        case Video
        case GIF
    }
    
    var mediaUrl:String?
    var mediaUrls:[String]?
    var sourceType:SourceType
    var mediaType:MediaType
    // 投稿者
    var userName:String?
    var userIconUrl:String?
    // その他
    var fullText:String?    // 本文
    
    init(sourceType:SourceType, mediaType:MediaType) {
        self.sourceType = sourceType
        self.mediaType = mediaType
    }
    
    // twitter
    init(tweet:Twitter.Tweet) {
        self.sourceType = .Twitter
        self.mediaType = .Image //default

        super.init()

        if let exapandedEntities = tweet.extendedEntities {
            if let medias = exapandedEntities.medias {
                if medias.count > 1 {
                    self.mediaType = .ImageSet
                    self.mediaUrls = []
                    for media in medias {
                        self.mediaUrls?.append(media.mediaUrlHttps!)
                    }
                    self.url = medias.first?.expandedUrl
                }
                else {
                    if let media = medias.first {
                        if let type = media.type {
                            // 1枚
                            if type == "photo" {
                                self.mediaType = .Image
                            }
                            else {
                                //...
                            }
                        }
                        self.url = media.expandedUrl
                        self.mediaUrl = media.mediaUrlHttps!
                    }
                }
            }
        }
        else if let entities = tweet.entities {
            if let media = entities.medias?.first {
                if let type = media.type {
                    if type == "photo" {
                        self.mediaType = .Image
                    }
                }
                self.url = media.expandedUrl
                self.mediaUrl = media.mediaUrlHttps!
            }
        }

        self.userName = tweet.user?.name!
        self.userIconUrl = tweet.user?.profileImageUrlHttps!
        self.fullText = tweet.fullText!
    }
    
    static func initArray(tweets:[Twitter.Tweet]) -> [FanArt] {
        var array:[FanArt] = []
        for tweet in tweets {
            let fanArt = FanArt.init(tweet: tweet)
            array.append(fanArt)
        }
        return array
    }
    
    func firstImageURL() -> String {
        if let mediaUrls = mediaUrls {
            if !mediaUrls.isEmpty {
                return mediaUrls.first!
            }
        }
        if let mediaUrl = mediaUrl {
            return mediaUrl
        }
        return ""
    }
}

