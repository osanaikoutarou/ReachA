//
//  WikipediaUtility.swift
//  ReachA
//
//  Created by 長内幸太郎 on 2018/04/05.
//  Copyright © 2018年 osanai. All rights reserved.
//

import UIKit

class WikipediaUtility: NSObject {

    static func createWikipediaPage(_ contentHtml: String, padding: UIEdgeInsets) -> String {
        let html1:String =
        """
            <!DOCTYPE html>
            <html>
                <head>
                <meta charset='UTF-8'>
                <script src='index.js'></script>
        """
        let html2:String =
        """
                <meta name='viewport' id='viewport' content='width=device-width, user-scalable=no, initial-scale=1.0'>
        """
        let html3:String =
        """
                </head>
                <body style='padding-top: 0px;'>
                    "<div class='content' id='content' style='margin-left: 0px;margin-right: 0px;'>
        """
        let html4:String =
        """
                    </div>
                </body>
            </html>
        """
        
        let indexJsPath = Bundle.main.path(forResource:"index", ofType:"js")
        let stylesCssPath = Bundle.main.path(forResource:"styles", ofType:"css")
        let wikimediaCssPath = Bundle.main.path(forResource:"wikimedia-page-library-transform", ofType:"css")
        let styleoverridesCssPath = Bundle.main.path(forResource:"styleoverrides", ofType:"css")
        
        // なんかCSS適用されないな
        let indexJsHtml = String(format:"<script src='%@'></script>", indexJsPath!)
        let stylesCssHtml = String(format:"<link href='%@' rel='stylesheet' type='text/css'></link>", stylesCssPath!)
        let wikimediaCssHtml = String(format:"<link href='%@' rel='stylesheet' type='text/css'></link>", wikimediaCssPath!)
        let styleoverridesCssHtml = String(format:"<link href='%@' rel='stylesheet' type='text/css'></link>", styleoverridesCssPath!)
        
        var html = ""
        html += html1
        html += indexJsHtml
        html += html2
        html += stylesCssHtml
        html += wikimediaCssHtml
        html += styleoverridesCssHtml
        html += html3
        html += contentHtml
        html += html4
        
        return html
    }

}
