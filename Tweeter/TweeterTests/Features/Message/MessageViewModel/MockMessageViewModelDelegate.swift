//
//  MockMessageViewModelDelegate.swift
//  TweeterTests
//
//  Created by MACOS on 3/10/19.
//  Copyright © 2019 MACOS. All rights reserved.
//

import XCTest
@testable import Tweeter

class MockMessageViewModelDelegate: MessageViewModelDelegate {
    var wasCalledUpdateBottomConst = false
    var wasCalledShowError = false
    var wasCalledUpdateLayoutSendMessageSuccess = false
    var wasCallUpdateButtonState = false
    var isEnableButton: Bool?
    
    func updateMessageViewBottomConstraint(with keyboardInfo: KeyboardAnimationInfo) {
        wasCalledUpdateBottomConst = true
    }
    
    func updateSendButtonState(isEnable: Bool) {
        isEnableButton = isEnable
        wasCallUpdateButtonState = true
    }
    
    func updateLayoutSendMessageSuccess() {
        wasCalledUpdateLayoutSendMessageSuccess = true
    }
    
    func showError(_ message: String) {
        wasCalledShowError = true
    }
    
}

