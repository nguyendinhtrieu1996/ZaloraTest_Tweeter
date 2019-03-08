//
//  Dimension.swift
//  Tweeter
//
//  Created by MACOS on 3/7/19.
//  Copyright © 2019 MACOS. All rights reserved.
//

import UIKit

public class Dimension {
    public static var shared = Dimension()
    
    private init() {
    }
    
    public var defaultMessageFont: UIFont {
        return UIFont.systemFont(ofSize: 14)
    }
    
    public var defaultMessageInsets: UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    }
    
    public var bubbleViewMaxLayoutWith: CGFloat {
        return 250
    }
}
