//
//  MockMessageViewModel.swift
//  TweeterTests
//
//  Created by Nguyen Dinh Trieu on 3/11/19.
//  Copyright © 2019 MACOS. All rights reserved.
//

import Foundation
@testable import Tweeter

class MockMessageViewModel: MessageViewModel {
    var wasCallKeyboardChangeFrame = false
    
    override func keyBoardChangeFrame(_ notification: NSNotification) {
        wasCallKeyboardChangeFrame = true
        super.keyBoardChangeFrame(notification)
    }
}
