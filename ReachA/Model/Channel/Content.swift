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

/////////////////////////

class YoutubeVideo : Video {
    var youtubeId:String? = ""
}
