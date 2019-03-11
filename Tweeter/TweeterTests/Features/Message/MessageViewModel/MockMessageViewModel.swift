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
    var wasCalledKeyboardChangeFrame = false
    var wasCalledViewModelForCell = false
    
    override func keyBoardChangeFrame(_ notification: NSNotification) {
        wasCalledKeyboardChangeFrame = true
        super.keyBoardChangeFrame(notification)
    }
    
    override func viewModelForCell(at index: Int) -> MessageCellViewModel? {
        wasCalledViewModelForCell = true
        return super.viewModelForCell(at: index)
    }
}
