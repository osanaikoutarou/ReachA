//
//  YoutubeApp.swift
//  ReachA
//
//  Created by 長内幸太郎 on 2018/03/02.
//  Copyright © 2018年 osanai. All rights reserved.
//

import Foundation
import UIKit

class YoutubeApp {
    
    func openYoutube(youtubeVideo:YoutubeVideo) {
        
        let appURL = youtubeVideo.url?.replacingOccurrences(of: "https", with: "youtube").url
        let webURL = youtubeVideo.url!.url
        
//        let YoutubeQuery =  "Your Query"
//        let escapedYoutubeQuery = YoutubeQuery.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
//        let appURL = NSURL(string: "youtube://www.youtube.com/results?search_query=\(escapedYoutubeQuery!)")!
//        let webURL = NSURL(string: "https://www.youtube.com/results?search_query=\(escapedYoutubeQuery!)")!
        let application = UIApplication.shared
        
        if application.canOpenURL(appURL!) {
            application.open(appURL!)
        }
        else {
            application.open(webURL)
        }
    }
    
}
