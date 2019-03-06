//
//  UIApllication+Extension.swift
//  Tweeter
//
//  Created by MACOS on 3/6/19.
//  Copyright © 2019 MACOS. All rights reserved.
//

import UIKit

extension UIApplication {
    var bottomSafeAreaInsets: CGFloat {
        if #available(iOS 11, *) {
            let window = UIApplication.shared.keyWindow
            return window?.safeAreaInsets.bottom ?? 0
        }
        return 0
    }
}
