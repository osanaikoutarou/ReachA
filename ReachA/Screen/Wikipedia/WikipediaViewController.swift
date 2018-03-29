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

class WikipediaViewController: UIViewController  {
    
    @IBOutlet weak var wkWebView: WKWebView!
    
    var urlString:String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Alamofire.request("http://ja.wikipedia.org/w/api.php?format=json&action=query&prop=revisions&titles=%E3%82%86%E3%82%8B%E3%82%AD%E3%83%A3%E3%83%B3%E2%96%B3&rvprop=content& rvparse").response { (response:DefaultDataResponse) in
            print(response)
        }
        
        if let urlString = urlString {
            wkWebView.load(with: urlString)
        }
    }

    func setupWithTitle(title:String) {
        urlString = "https://ja.wikipedia.org/wiki/%E3%82%86%E3%82%8B%E3%82%AD%E3%83%A3%E3%83%B3%E2%96%B3"//"https://ja.wikipedia.org/wiki/" + title.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
    }

}
