//
//  MessageTests.swift
//  TweeterTests
//
//  Created by MACOS on 3/10/19.
//  Copyright © 2019 MACOS. All rights reserved.
//

import XCTest
@testable import Tweeter

class MessageTests: XCTestCase {
    override func setUp() {
    }

    override func tearDown() {
    }

    func testSplitMessage_ReturnMessageWhenLessThanMaxLength() {
        let messages = Message.splitMessage(TextTestCase.text10Character)
        XCTAssertEqual(messages?.count, 1)
        XCTAssertEqual(messages?.first, Message(text: TextTestCase.text10Character))
    }
    
    func testSplitMessage_ReturnMessageWhenEqualMaxLength() {
        let messages = Message.splitMessage(TextTestCase.text50Character)
        XCTAssertEqual(TextTestCase.text50Character.count, Message.maxLenght)
        XCTAssertEqual(messages?.count, 1)
        XCTAssertEqual(messages?.first, Message(text: TextTestCase.text50Character))
    }
    
    func testSplitMessage_Return2Parts() {
        let messages = Message.splitMessage(TextTestCase.textSplitTwoParts)
        XCTAssertEqual(messages?.count, 2)
    }
    
    func testSplitMessage_Return26Parts() {
        let messages = Message.splitMessage(TextTestCase.textSplit26Parts)
        XCTAssertEqual(messages?.count, 26)
    }
    
    func testSplitMessage_Return108Parts() {
        let messages = Message.splitMessage(TextTestCase.textSplit108Parts)
        XCTAssertEqual(messages?.count, 108)
    }
    
    func testSplitMessage_WhenTestDoNotContainWhiteSpace_ReturnNil() {
        let messages = Message.splitMessage(TextTestCase.textGreate50CharacterDoNotContainWhiteSpace)
        XCTAssertNil(messages)
    }
    
}
