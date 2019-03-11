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
    
}

// MARK: - Tests Properties

extension MessageViewModelTests {
    func testNumberOfMessages_EqualMessagesCount() {
        XCTAssertEqual(sut.numberMessages, messages.count)
    }
    
    func testLastMessageIndexpath() {
        let expectedIndexPath = IndexPath(row: messages.count - 1, section: 0)
        XCTAssertEqual(sut.lastMessageIndexPath, expectedIndexPath)
    }
}

// MARK: - Tests viewModelForCell

extension MessageViewModelTests {
    func testViewModelForCell_WhenIndexOutOfRange_ReturnNil() {
        XCTAssertNil(sut.viewModelForCell(at: messages.count))
    }
    
    func testViewModelForCell_ReturnCellViewModelNotNill() {
        XCTAssertNotNil(sut.viewModelForCell(at: 0))
    }
}

// MARK: - Tests keyboardChangeFrame

extension MessageViewModelTests {
    func testKeyboardChangeFrame_WhenUserInfoIsNil_DoNotCallDelegate() {
        let delegate = MockMessageViewModelDelegate()
        sut.delegate = delegate
        sut.keyBoardChangeFrame(NSNotification(name: NSNotification.Name(rawValue: ""), object: nil))
        XCTAssertFalse(delegate.wasCalledUpdateBottomConst)
    }
    
    func testKeyBoardChangeFrame_CallDelegateUpdateConst() {
        let delegate = MockMessageViewModelDelegate()
        sut.delegate = delegate
        sut.keyBoardChangeFrame(fakeNSNotification)
        XCTAssertTrue(delegate.wasCalledUpdateBottomConst)
    }
}

// MARK: - Tests didSelectSendButton

extension MessageViewModelTests {
    func testDidSelectSendButton_WhenCanNotSplitMessage_ShowError() {
        let mockDelegate = MockMessageViewModelDelegate()
        sut.delegate = mockDelegate
        sut.didSelectSendButton(with: TextTestCase.textOver50CharacterDoNotContainWhiteSpace)
        XCTAssertTrue(mockDelegate.wasCalledShowError)
    }
    
    func testDidSelectSendButon_InCreaseNumberOfMessage() {
        let currentMessages = sut.numberMessages
        let text = "I can't believe Tweeter now supports chunking my messages, so I don't have to do it myself."
        sut.didSelectSendButton(with: text)
        let expectedMessages = currentMessages + Message.splitMessage(text)!.count
        XCTAssertEqual(sut.numberMessages, expectedMessages)
    }
    
    func testDidSelectSendButton_WhenSplitMessage_CallUpdateLayout() {
        let mockDelegate = MockMessageViewModelDelegate()
        sut.delegate = mockDelegate
        let text = "I can't believe Tweeter now supports chunking my messages, so I don't have to do it myself."
        sut.didSelectSendButton(with: text)
        XCTAssertTrue(mockDelegate.wasCalledUpdateLayoutSendMessageSuccess)
    }
}

// MARK: - inputTextValueChange

extension MessageViewModelTests {
    func testInputTextValueChange_WhenTextEqualNil_CallUpdateButtonAndDisable() {
        let mockDelegate = MockMessageViewModelDelegate()
        sut.delegate = mockDelegate
        sut.inputTextValueChange(with: nil)
        XCTAssertTrue(mockDelegate.wasCallUpdateButtonState)
        XCTAssertFalse(mockDelegate.isEnableButton!)
    }
    
    func testInputTextValueChange_WhenTextEqualEmpty_CallUpdateButtonAndDisable() {
        let mockDelegate = MockMessageViewModelDelegate()
        sut.delegate = mockDelegate
        sut.inputTextValueChange(with: "")
        XCTAssertTrue(mockDelegate.wasCallUpdateButtonState)
        XCTAssertFalse(mockDelegate.isEnableButton!)
    }
    
    func testInputTextValueChange_WhenValidText_CallUpdateButtonStateAndEnable() {
        let mockDelegate = MockMessageViewModelDelegate()
        sut.delegate = mockDelegate
        sut.inputTextValueChange(with: "I can't believe Tweeter now supports chunking my messages, so I don't have to do it myself.")
        XCTAssertTrue(mockDelegate.wasCallUpdateButtonState)
        XCTAssertTrue(mockDelegate.isEnableButton!)
    }
}
