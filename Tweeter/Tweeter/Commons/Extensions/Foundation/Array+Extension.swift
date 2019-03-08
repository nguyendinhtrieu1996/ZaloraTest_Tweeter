//
//  Array+Extension.swift
//  Tweeter
//
//  Created by Nguyen Dinh Trieu on 3/8/19.
//  Copyright © 2019 MACOS. All rights reserved.
//

import Foundation

extension Array {
    subscript(safe index: Int) -> Element? {
        if index < count {
            return self[index]
        } else {
            return nil
        }
    }
}
