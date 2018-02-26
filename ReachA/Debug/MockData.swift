//
//  MockData.swift
//  ReachA
//
//  Created by 長内幸太郎 on 2018/02/25.
//  Copyright © 2018年 osanai. All rights reserved.
//

import UIKit

class MockData: NSObject {
    
    func channels() -> [Channel] {
        
        var result:[Channel] = []
        
        let yurukyan = Anime()
        yurukyan.name = "ゆるキャン△"
        yurukyan.officialUrl = "http://yurucamp.jp/"
        yurukyan.wikipedia = "https://ja.wikipedia.org/wiki/%E3%82%86%E3%82%8B%E3%82%AD%E3%83%A3%E3%83%B3%E2%96%B3"
        yurukyan.twitterScreenName = "yurucamp_anime"
        result.append(yurukyan)
        
        let citorus = Anime()
        citorus.name = "citorus"
        citorus.officialUrl = "http://citrus-anime.com/"
        citorus.wikipedia = "https://ja.wikipedia.org/wiki/Citrus_(%E6%BC%AB%E7%94%BB)"
        citorus.twitterScreenName = "citrus_anime"
        result.append(citorus)
        
        let mitubosiColors = Anime()
        mitubosiColors.name = "三ツ星カラーズ"
        mitubosiColors.officialUrl = "http://mitsuboshi-anime.com/"
        mitubosiColors.wikipedia = "https://ja.wikipedia.org/wiki/%E4%B8%89%E3%83%84%E6%98%9F%E3%82%AB%E3%83%A9%E3%83%BC%E3%82%BA"
        mitubosiColors.twitterScreenName = "3boshi_anime"
        result.append(mitubosiColors)
        
        return result
    }
}
