//
//  JsonLoader.swift
//  RandomCollectionView
//
//  Created by osanai on 2018/09/21.
//  Copyright © 2018年 osanai.sample.copytesting. All rights reserved.
//

import UIKit

// 機能部分
extension JsonLoader {
    
    static func load(resourceName:String) -> Any? {
        let filepath = Bundle.main.url(forResource: resourceName, withExtension: "json")
        if let filepath = filepath {
            do {
                let data = try Data(contentsOf: filepath)
                let jsonResult = try! JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                return jsonResult
            } catch {
                print("error")
            }
        }
        return nil
    }
}

class JsonLoader: NSObject {
    static let shared = JsonLoader()
    
    var channels:[Channel] = []
    
    func loadAll() {
        channels = JsonLoader.loadChannels()
    }
}

extension JsonLoader {
    
    static func loadChannels() -> [Channel] {
        var result:[Channel] = []
        
        let jsonResult = load(resourceName: "ChannelData")
        
        if let jsonResult = jsonResult as? [[String:Any]] {
            jsonResult.forEach { (data:[String:Any]) in
                let channel = Channel.create(data)
                result.append(channel)
                
                channel.printDescription()
            }
            
            return result
        }
        return []
    }
    
}
