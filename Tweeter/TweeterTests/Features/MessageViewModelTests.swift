//
//  MessageViewModelTests.swift
//  TweeterTests
//
//  Created by MACOS on 3/10/19.
//  Copyright © 2019 MACOS. All rights reserved.
//

import XCTest
@testable import Tweeter

class MessageViewModelTests: XCTestCase {
    let messages = [Message(text: "1/2 I can't believe Tweeter now supports chunking"),
                    Message(text: "2/2 my messages, so I don't have to do it myself.")]
    lazy var sut = MessageViewModel(with: messages)
    let userInfo: [AnyHashable: Any] = [UIResponder.keyboardFrameEndUserInfoKey: 300]
    lazy var fakeNSNotification = NSNotification(name: NSNotification.Name(rawValue: "FakeNoti"),
                                                 object: nil,
                                                 userInfo: userInfo)
    
    
    override func setUp() {
        sut = MessageViewModel(with: messages)
    }
    
    override func tearDown() {
    }
    
    func testNumberOfMessages() {
        XCTAssertEqual(sut.numberMessages, messages.count)
    }
    
    func testLastMessageIndexpath() {
        let expectIndexPath = IndexPath(row: messages.count - 1, section: 0)
        XCTAssertEqual(sut.lastMessageIndexPath, expectIndexPath)
    }
    
    func testViewModelForCellOfOfIndexReturnNil() {
        XCTAssertNil(sut.viewModelForCell(at: messages.count))
    }
    
    func testViewModelForCellReturnCellViewModel() {
        XCTAssertNotNil(sut.viewModelForCell(at: 0))
    }
    
    func testKeyboardChangeFrameDoNotCellDelegate() {
        let delegate = MockMessageViewModelDelegate()
        sut.delegate = delegate
        sut.keyBoardChangeFrame(NSNotification(name: NSNotification.Name(rawValue: ""), object: nil))
        XCTAssertFalse(delegate.wasCalledUpdateBottomConst)
    }
    
    func testKeyBoardChangeFrameCallDelegateUpdateConst() {
        let delegate = MockMessageViewModelDelegate()
        sut.delegate = delegate
        sut.keyBoardChangeFrame(fakeNSNotification)
        XCTAssertTrue(delegate.wasCalledUpdateBottomConst)
    }
    
}

