//
//  WikipediaBaseViewController.swift
//  ReachA
//
//  Created by 長内幸太郎 on 2018/03/11.
//  Copyright © 2018年 osanai. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class WikipediaBaseViewController: SlideMenuController {

    override func awakeFromNib() {
        if let controller:WikipediaViewController
            = self.storyboard?.instantiateViewController(withIdentifier: "WikipediaViewController") as? WikipediaViewController {
            self.mainViewController = controller
            controller.setupWithTitle(title: "")
        }
        if let controller = self.storyboard?.instantiateViewController(withIdentifier: "WikipediaMenuViewController") {
            self.rightViewController = controller
        }
        
        SlideMenuOptions.rightViewWidth = 250
        SlideMenuOptions.contentViewScale = 1.0
        SlideMenuOptions.opacityViewBackgroundColor = UIColor.clear
        SlideMenuOptions.simultaneousGestureRecognizers = false
        SlideMenuOptions.animationDuration = 0.2
        
        super.awakeFromNib()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
    }
    
    func setupNavBar() {
        self.edgesForExtendedLayout = []
        self.navigationController?.title = ""
        clearNavBar()
    }
    func clearNavBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }

    @IBAction func tappedMenuButton(_ sender: Any) {
        if (self.slideMenuController()?.isRightOpen())! {
            closeRight()
        }
        else {
            openRight()
        }
    }
    
    @IBAction func tappedCloseButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
