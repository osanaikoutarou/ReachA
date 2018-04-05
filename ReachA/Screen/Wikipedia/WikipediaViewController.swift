//
//  WikipediaViewController.swift
//  ReachA
//
//  Created by 長内幸太郎 on 2018/03/11.
//  Copyright © 2018年 osanai. All rights reserved.
//

import UIKit
import WebKit
import Alamofire
import SwiftyJSON
import Kanna

// まんどくせｗ
//class MediaWiki {
//    struct Warning : Codable {
//    }
//    struct Main {
//
//    }
//    struct Root : Codable{
//        let batchcomplete: String
//        let warnings:[Warning]
//    }
//}


class WikipediaViewController: UIViewController  {
    
    @IBOutlet weak var wkWebView: WKWebView!
    
    var urlString:String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Alamofire.request("https://ja.wikipedia.org/w/api.php?format=json&action=query&prop=revisions&titles=%E3%82%86%E3%82%8B%E3%82%AD%E3%83%A3%E3%83%B3%E2%96%B3&rvprop=content&rvparse").responseJSON { response in
            
            var json:JSON?
            
            switch response.result {
            case .success(let value):
                json = JSON(value)
//                print("JSON: \(json!)")
            case .failure(let error):
                print(error)
            }
            
            guard let _ = json else {
                return
            }
            
            let htmlString = json!["query"]["pages"]["3550514"]["revisions"][0]["*"].string
            print("htmlString: \(htmlString!)")
            
            
            
            
            
            
            
//            self.wkWebView.loadHTMLString(htmlString!, baseURL: "https://ja.wikipedia.org/w/api.php?format=json&action=query&prop=revisions&titles=%E3%82%86%E3%82%8B%E3%82%AD%E3%83%A3%E3%83%B3%E2%96%B3&rvprop=content&rvparse".url)
            
//            self.wkWebView.loadHTML(htmlString!, baseURL: "https://ja.wikipedia.org/w/api.php?format=json&action=query&prop=revisions&titles=%E3%82%86%E3%82%8B%E3%82%AD%E3%83%A3%E3%83%B3%E2%96%B3&rvprop=content&rvparse".url, padding: UIEdgeInsets.zero)
            
            
            
            
            
            if let doc = try? HTML(html: htmlString!, encoding: .utf8) {
                print(doc.title ?? "titleなし")
                
                // Search for nodes by CSS
                for link in doc.css("a, link") {
                    print(link.text ?? "なし")
                    print(link["href"] ?? "なし")
                }
                
                // Search for nodes by XPath
                for link in doc.xpath("//a | //link") {
                    print(link.text ?? "なし")
                    print(link["href"] ?? "なし")
                }
            }
            
            
            
            
            self.wkWebView.loadWikipediaPage(htmlString!, baseURL: "https://ja.wikipedia.org/w/api.php?format=json&action=query&prop=revisions&titles=%E3%82%86%E3%82%8B%E3%82%AD%E3%83%A3%E3%83%B3%E2%96%B3&rvprop=content&rvparse".url, padding: UIEdgeInsets.zero)
            
            
//            json["query"]["pages"]["3550514"]["revisions"].forEach({ (_, data) in
//                print(data.string ?? "あう")
//            })
            
        }
        
//        if let urlString = urlString {
//            wkWebView.load(with: urlString)
//        }
    }

    func setupWithTitle(title:String) {
        urlString = "https://ja.wikipedia.org/wiki/%E3%82%86%E3%82%8B%E3%82%AD%E3%83%A3%E3%83%B3%E2%96%B3"//"https://ja.wikipedia.org/wiki/" + title.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
    }

}
