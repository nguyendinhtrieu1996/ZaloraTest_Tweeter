
//
//  MockInputMessageView.swift
//  TweeterTests
//
//  Created by Nguyen Dinh Trieu on 3/11/19.
//  Copyright © 2019 MACOS. All rights reserved.
//

import UIKit
@testable import Tweeter

class MockInputMessageView: InputMessageView {
    var wasCalledUpdateSendButtonState = false
    var wasCalledClearInputText = false
    
    override func updateSendButtonState(isEnable: Bool) {
        wasCalledUpdateSendButtonState = true
        super.updateSendButtonState(isEnable: isEnable)
    }
    
    override func clearInputText() {
        wasCalledClearInputText = true
        super.clearInputText()
    }
}
