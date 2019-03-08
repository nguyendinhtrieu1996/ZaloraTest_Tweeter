//
//  Theme.swift
//  Tweeter
//
//  Created by MACOS on 3/7/19.
//  Copyright © 2019 MACOS. All rights reserved.
//

import UIKit

public class Theme {
    public static var shared = Theme()
    
    private init() {
    }
    
    public var defaultTextColor: UIColor {
        return UIColor.white
    }
    
}
