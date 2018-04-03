//
//  WKWebView+Utility.swift
//  ReachA
//
//  Created by 長内幸太郎 on 2018/03/11.
//  Copyright © 2018年 osanai. All rights reserved.
//

import Foundation
import WebKit

extension WKWebView {
    
    func load (with urlStr:String) {
        if !urlStr.isEmpty {
            if let url = urlStr.url {
                let urlRequest = URLRequest(url: url)
                self.load(urlRequest)
            }
        }
    }
    
    
    func loadHTML(_ string: String?, baseURL: URL?, withAssetsFile fileName: String?, scrolledToFragment fragment: String?, padding: UIEdgeInsets) {
        guard
            let fileName = fileName,
            let baseURL = baseURL,
            let articleDatabaseKey = baseURL.wmf_articleDatabaseKey
            else {
                DDLogError("window, proxyServer, baseURL or fileName not found");
                return
        }

        let localFilePath = Bundle().path(forResource: "wikipedia", ofType: "html")
        
        guard let fileContents = try? String(contentsOfFile: localFilePath, encoding: String.Encoding.utf8) else {
//            DDLogError("\(localFilePath) contents not found");
            print("ほげー")
            return
        }
        
//        assert(fileContents.split(separator: "@").count == (5 + 1), """
//                HTML template file does not have required number of percent-ampersand occurences (5).
//                Number of percent-ampersands must match number of values passed to 'stringWithFormat:'
//        """)
        
//        let headTagAddition = stringToInjectIntoHeadTag(fontSize: UserDefaults.wmf_userDefaults().wmf_articleFontSizeMultiplier(), baseURL: baseURL)
        
        // index.html and preview.html have 5 "%@" subsitition markers. Replace these with actual content.
        let templateAndContent = String(format: fileContents, headTagAddition, padding.top as NSNumber, padding.left as NSNumber, padding.right as NSNumber, string ?? "")
        
        let requestPath = "\(articleDatabaseKey.hash)-\(fileName)"
        proxyServer.setResponseData(templateAndContent.data(using: String.Encoding.utf8), withContentType: "text/html; charset=utf-8", forPath: requestPath)
        
        print("パスやて？　" + requestPath)
        
        loadHTMLFromAssetsFile(requestPath, scrolledToFragment: fragment)
    }
}








import WebKit
import WMF

let WKWebViewLoadAssetsHTMLRequestTimeout: TimeInterval = 60; //60s is the default NSURLRequest timeout interval

extension WKWebView {
    
    // Loads contents of fileName. Assumes the file is in the "assets" folder.
    @objc func loadHTMLFromAssetsFile(_ fileName: String?, scrolledToFragment fragment: String?) {
        guard
            let fileName = fileName,
            let requestURL = WMFProxyServer.shared().proxyURL(forRelativeFilePath: fileName, fragment: fragment ?? "top")
            else {
                DDLogError("attempted to load nil fileName or requestURL");
                return
        }
        self.load(URLRequest.init(url: requestURL, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: WKWebViewLoadAssetsHTMLRequestTimeout))
    }
    
    // チェック:なんだこれ　うわ、html生成してる！？　もしくは改変してるのかな
    // Loads html passed to it injected into html from fileName.
    @objc
    
    fileprivate func stringToInjectIntoHeadTag(fontSize: NSNumber, baseURL: URL, theme: Theme) -> String {
        /*
         The 'theme' and 'compatibility' calls are deliberately injected specifically into the head tag via an inline script because:
         "... inline scripts are fetched and executed immediately, before the browser continues to parse the page"
         https://developer.mozilla.org/en-US/docs/Web/HTML/Element/script
         
         This ensures all theme settings are in place before any page rendering occurs.
         
         'compatibility.enableSupport()'
         Needs to happen only once but *before* body elements are present and before
         calling 'themes.setTheme()'.
         
         'themes.setTheme()'
         Needs to happen before body elements are present so these will appear with
         correct theme colors already set. (This method is also used to changes themes,
         but changing themes doesn't require 'compatibility.enableSupport()' or
         'themes.classifyElements()' be called again.)
         
         Reminder:
         We don't want to use 'addUserScript:' with WKUserScriptInjectionTimeAtDocumentEnd for this because
         it happens too late - at 'DocumentEnd'. We want the colors to be set before this so there is never
         a flickering color change visible to the user. We can't use WKUserScriptInjectionTimeAtDocumentBegin
         because this fires before any of the head tag contents are resolved, including references to our JS
         libraries - we'd have to make a larger set of changes to make this work.
         */
        return """
        <style type='text/css'>
        body {
        -webkit-text-size-adjust: \(fontSize)%;
        }
        </style>
        <base href="\(baseURL.absoluteString)">
        <script type='text/javascript'>
        window.wmf.compatibility.enableSupport(document)
        window.wmf.platform.classify(window)
        \(WKWebView.wmf_themeApplicationJavascript(with: theme))
        </script>
        """
    }
}







////
////  WKWebViewBaseView.m
////  SuperCustomWebView
////
////  Created by 長内　幸太郎 on 2016/06/29.
////  Copyright © 2016年 長内　幸太郎. All rights reserved.
////
//
//#import "WKWebViewBaseView.h"
//
//const BOOL debug = NO;
//
//@implementation WKWebViewBaseView {
//    UIEdgeInsets contentInset;
//}
//
//#pragma mark -
//
//// コードで追加したい場合
//+ (instancetype)view {
//    NSString *className = NSStringFromClass([self class]);
//    return [[[NSBundle mainBundle] loadNibNamed:className owner:nil options:0] firstObject];
//}
//
//
//#pragma mark - setupWKWebView
//
//// inset有り
//- (void)setupWithInsets:(UIEdgeInsets)inset url:(NSURL *)url {
//    contentInset = inset;
//    
//    [self setupWKWebViewDefault];
//    [self setupObserver];
//    
//    //    [self setupAutoLayout];
//    [self addSubview:self.wkWebView];
//    
//    if (url && url.absoluteString && url.absoluteString.length>0) {
//        [self.wkWebView loadRequest:[NSURLRequest requestWithURL:url]];
//    }
//    }
//    
//    - (void)setupAndLoad:(NSURL *)url {
//        [self setupWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) url:url];
//        }
//        
//        // insetはゼロ
//        - (void)setupWKWebViewDefault {
//            
//            self.wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
//            self.wkWebView.navigationDelegate = self;
//            self.wkWebView.allowsBackForwardNavigationGestures = YES;
//}
//
//#pragma mark - layout
//
//- (void)layoutSubviews {
//    [super layoutSubviews];
//    [self.wkWebView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
//    
//    //???:ContentInsetがTopに挟まれることがあるため
//    //FIXME:部分最適となっている、カスタマイズが必要かも
//    self.wkWebView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
//    }
//    
//    - (void)dealloc {
//        [self removeObservers];
//}
//
//#pragma mark - observer
//
//- (void)setupObserver {
//    // 全部監視
//    [self.wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
//    [self.wkWebView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
//    [self.wkWebView addObserver:self forKeyPath:@"loading" options:NSKeyValueObservingOptionNew context:nil];
//    [self.wkWebView addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:nil];
//    [self.wkWebView addObserver:self forKeyPath:@"canGoForward" options:NSKeyValueObservingOptionNew context:nil];
//    
//    [self log:@"[WKWebViewBaseView] observer start"];
//    }
//    
//    - (void)removeObservers {
//        [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
//        [self.wkWebView removeObserver:self forKeyPath:@"title"];
//        [self.wkWebView removeObserver:self forKeyPath:@"loading"];
//        [self.wkWebView removeObserver:self forKeyPath:@"canGoBack"];
//        [self.wkWebView removeObserver:self forKeyPath:@"canGoForward"];
//        
//        [self log:@"[WKWebViewBaseView] observer stop"];
//}
//
//#pragma mark - NSKeyValueObserving methods
//
//- (void)observeValueForKeyPath:(NSString *)keyPath
//ofObject:(id)object
//change:(NSDictionary *)change
//context:(void *)context {
//    
//    if ([keyPath isEqualToString:@"estimatedProgress"]) {
//        [self log:@"[WKWebViewBaseView](Key) estimatedProgress"];
//        
//        // ex:プログレスバーを更新する
//        // self.wkWebView.estimatedProgress * 100.0f
//        // [self.navigationController setSGProgressPercentage:self.webView.estimatedProgress * 100.0f];
//        
//        if (self.changedEstimatedProgressBlock) {
//            self.changedEstimatedProgressBlock(self.wkWebView.estimatedProgress);
//        }
//    }
//    else if ([keyPath isEqualToString:@"title"]) {
//        [self log:@"[WKWebViewBaseView](Key) title"];
//        
//        // titleが変更された
//        // self.title = self.webView.title;
//        
//        if (self.changedTitleBlock) {
//            self.changedTitleBlock(self.wkWebView.title);
//        }
//    }
//    else if ([keyPath isEqualToString:@"loading"]) {
//        [self log:@"[WKWebViewBaseView](Key) loading"];
//        
//        // load中かどうか
//        // self.wkWebView.loading
//        // [UIApplication sharedApplication].networkActivityIndicatorVisible = self.wkWebView.loading;
//        
//        // ex:リロードボタンと読み込み停止ボタンの有効・無効を切り替える
//        // self.reloadButton.enabled = !self.wkWebView.loading;
//        // self.stopButton.enabled = self.wkWebView.loading;
//        
//        if (self.changedLoadingBlock) {
//            self.changedLoadingBlock(self.wkWebView.loading);
//        }
//    }
//    else if ([keyPath isEqualToString:@"canGoBack"]) {
//        [self log:@"[WKWebViewBaseView](Key) canGoBack"];
//        
//        // ex:「＜」ボタンの有効・無効を切り替える
//        // self.backButton.enabled = self.wkWebView.canGoBack;
//        
//        if (self.changedCanGoBackBlock) {
//            self.changedCanGoBackBlock(self.wkWebView.canGoBack);
//        }
//    }
//    else if ([keyPath isEqualToString:@"canGoForward"]) {
//        [self log:@"[WKWebViewBaseView](Key) canGoForward"];
//        
//        // ex:「＞」ボタンの有効・無効を切り替える
//        // self.forwardButton.enabled = self.wkWebView.canGoForward;
//        
//        if (self.changedCanGoForwardBlock) {
//            self.changedCanGoForwardBlock(self.wkWebView.canGoForward);
//        }
//    }
//}
//
//#pragma mark - Nav methods
//
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
//    [self log:@"[WKWebViewBaseView](Nav) decidePolicyForNavigationAction"];
//    
//    // 画面遷移前に判断する
//    // WKNavigationActionPolicyでCancel/Allow
//    if (self.decidePolicyForNavigationActionBlock) {
//        WKNavigationActionPolicy policy = self.decidePolicyForNavigationActionBlock(navigationAction);
//        decisionHandler(policy);
//    }
//    else {
//        // default許可
//        decisionHandler(WKNavigationActionPolicyAllow);
//    }
//    }
//    
//    - (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
//        [self log:@"[WKWebViewBaseView](Nav) decidePolicyForNavigationResponse"];
//        
//        // 画面遷移先のレスポンス次第で判断する
//        // WKNavigationActionPolicyでCancel/Allow
//        if (self.decidePolicyForNavigationResponseBlock) {
//            WKNavigationResponsePolicy policy = self.decidePolicyForNavigationResponseBlock(navigationResponse);
//            decisionHandler(policy);
//        }
//        else {
//            // default許可
//            decisionHandler(WKNavigationResponsePolicyAllow);
//        }
//        }
//        
//        - (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
//            [self log:@"[WKWebViewBaseView](Nav) didStartProvisionalNavigation"];
//            
//            // ページの読み込み準備開始
//            if (self.didStartProvisionalNavigationBlock) {
//                self.didStartProvisionalNavigationBlock(navigation);
//            }
//            }
//            
//            - (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
//                [self log:@"[WKWebViewBaseView](Nav) didCommitNavigation"];
//                [self log:@"    -ページ読み込み開始"];
//                
//                // ページが見つかり、読み込み開始
//                if (self.didCommitNavigationBlock) {
//                    self.didCommitNavigationBlock(navigation);
//                }
//                }
//                
//                - (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
//                    [self log:@"[WKWebViewBaseView](Nav) didFinishNavigation"];
//                    [self log:@"    -ページ読み込み完了"];
//                    
//                    // ページの読み込み完了
//                    if (self.didFinishNavigationBlock) {
//                        self.didFinishNavigationBlock(navigation);
//                    }
//                    }
//                    
//                    - (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
//                        [self log:@"[WKWebViewBaseView](Nav) didFailProvisionalNavigation"];
//                        [self log:@"    -ページ読み込み失敗"];
//                        
//                        // ページの読み込み失敗
//                        if (self.didFailProvisionalNavigationBlock) {
//                            self.didFailProvisionalNavigationBlock(navigation);
//                        }
//                        }
//                        
//                        - (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
//                            [self log:@"[WKWebViewBaseView](Nav) didReceiveServerRedirectForProvisionalNavigation"];
//                            
//                            // 表示中にリダイレクト
//                            if (self.didReceiveServerRedirectForProvisionalNavigationBlock) {
//                                self.didReceiveServerRedirectForProvisionalNavigationBlock(navigation);
//                            }
//}
//
//#pragma mark - method
//
//- (BOOL)goSafari {
//    [[UIApplication sharedApplication] openURL:self.wkWebView.URL];
//    return YES;
//}
//
//#pragma mark - DelegateMethod,Observe method 設定
//
//// 全て一気に設定
//- (void)setupMothodBlocksDecidePolicyForNavigationActionBlock:(DecidePolicyForNavigationActionBlock)decidePolicyForNavigationActionBlock
//DecidePolicyForNavigationResponseBlock:(DecidePolicyForNavigationResponseBlock)decidePolicyForNavigationResponseBlock
//DidStartProvisionalNavigationBlock:(DidStartProvisionalNavigationBlock)didStartProvisionalNavigationBlock
//DidCommitNavigationBlock:(DidCommitNavigationBlock)didCommitNavigationBlock
//DidFinishNavigationBlock:(DidFinishNavigationBlock)didFinishNavigationBlock
//DidFailProvisionalNavigationBlock:(DidFailProvisionalNavigationBlock)didFailProvisionalNavigationBlock
//DidReceiveServerRedirectForProvisionalNavigationBlock:(DidReceiveServerRedirectForProvisionalNavigationBlock)didReceiveServerRedirectForProvisionalNavigationBlock
//ChangedEstimatedProgressBlock:(ChangedEstimatedProgressBlock)changedEstimatedProgressBlock
//ChangedTitleBlock:(ChangedTitleBlock)changedTitleBlock
//ChangedLoadingBlock:(ChangedLoadingBlock)changedLoadingBlock
//ChangedCanGoBackBlock:(ChangedCanGoBackBlock)changedCanGoBackBlock
//ChangedCanGoForwardBlock:(ChangedCanGoForwardBlock)changedCanGoForwardBlock
//{
//    self.decidePolicyForNavigationActionBlock = decidePolicyForNavigationActionBlock;
//    self.decidePolicyForNavigationResponseBlock = decidePolicyForNavigationResponseBlock;
//    self.didStartProvisionalNavigationBlock = didStartProvisionalNavigationBlock;
//    self.didCommitNavigationBlock = didCommitNavigationBlock;
//    self.didFinishNavigationBlock = didFinishNavigationBlock;
//    self.didFailProvisionalNavigationBlock = didFailProvisionalNavigationBlock;
//    self.didReceiveServerRedirectForProvisionalNavigationBlock = didReceiveServerRedirectForProvisionalNavigationBlock;
//    self.changedEstimatedProgressBlock = changedEstimatedProgressBlock;
//    self.changedTitleBlock = changedTitleBlock;
//    self.changedLoadingBlock = changedLoadingBlock;
//    self.changedCanGoBackBlock = changedCanGoBackBlock;
//    self.changedCanGoForwardBlock = changedCanGoForwardBlock;
//    
//}
//
//#pragma mark - action
//
//
//#pragma mark - debug log
//
//- (void)log:(NSString *)str {
//    if (debug) {
//        NSLog(@"%@",str);
//    }
//}
//
//@end
//
