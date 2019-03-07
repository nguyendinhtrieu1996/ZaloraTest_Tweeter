//
//  UIEdgeInsets+Extension.swift
//  Tweeter
//
//  Created by MACOS on 3/7/19.
//  Copyright © 2019 MACOS. All rights reserved.
//

import UIKit

public extension UIEdgeInsets {
    public var horizontalInsets: CGFloat {
        return left + right
    }
    
    public var vericalInsets: CGFloat {
        return top + bottom
    }
}
