//
//  UIImageView+Fit.swift
//  ReachA
//
//  Created by 長内幸太郎 on 2018/03/06.
//  Copyright © 2018年 osanai. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func heightWhenFitWidth() -> CGFloat {
        guard let image = self.image else {
            return 0
        }
        let scale = self.frame.size.width/image.size.width
        return image.size.height * scale
    }
}
