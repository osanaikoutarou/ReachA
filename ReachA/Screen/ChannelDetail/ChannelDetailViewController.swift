//
//  ChannelDetailViewController.swift
//  ReachA
//
//  Created by osanai on 2018/01/16.
//  Copyright © 2018年 osanai. All rights reserved.
//

import UIKit
import WebKit

class ChannelDetailViewController: UIViewController,WKNavigationDelegate {
    
    @IBOutlet weak var wkWebView: WKWebView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "http://yurucamp.jp/")
        let urlRequest = URLRequest(url: url!)
        wkWebView.load(urlRequest)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
