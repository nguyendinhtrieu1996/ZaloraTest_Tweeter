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
    
    func testSplitMessage_WhenLessThanMaxLength_ReturnInputText() {
        let messages = Message.splitMessage(TextTestCase.text10Character)
        XCTAssertEqual(messages?.count, 1)
        XCTAssertEqual(messages?.first!.text, TextTestCase.text10Character)
    }
    
    func testSplitMessage_WhenEqualMaxLength_ReturnInputText() {
        let messages = Message.splitMessage(TextTestCase.text50Character)
        XCTAssertEqual(TextTestCase.text50Character.count, Message.maxLenght)
        XCTAssertEqual(messages?.count, 1)
        XCTAssertEqual(messages?.first!.text, TextTestCase.text50Character)
    }
    
    func testSplitMessage_WhenTestDoNotContainWhiteSpace_ReturnNil() {
        let messages = Message.splitMessage(TextTestCase.textOver50CharacterDoNotContainWhiteSpace)
        XCTAssertNil(messages)
    }
    
    func testSplitMessage_WhenTextOver50Character_ReturnCorrectMessages() {
        let messages = Message.splitMessage(TextTestCase.textOver50Character)!
        XCTAssertTrue(checkTotalPartCorrect(for: messages))
        XCTAssertTrue(checkEachPartLowerOrEqualMaxLength(for: messages))
    }
    
    func testSplitMessage_MediumText_ReturnCorrectMessages() {
        let messages = Message.splitMessage(TextTestCase.mediumText)!
        XCTAssertTrue(checkTotalPartCorrect(for: messages))
        XCTAssertTrue(checkEachPartLowerOrEqualMaxLength(for: messages))
    }
    
    func testSplitMessage_LongText_ReturnCorrectMessages() {
        let messages = Message.splitMessage(TextTestCase.longText)!
        XCTAssertTrue(checkTotalPartCorrect(for: messages))
        XCTAssertTrue(checkEachPartLowerOrEqualMaxLength(for: messages))
    }
    
}

// MARK: - Helper methods

extension MessageTests {
    func checkTotalPartCorrect(for messages: [Message]) -> Bool {
        let totalPart = messages.count
        for message in messages {
            if totalPart != getTotalPart(from: message.text) {
                return false
            }
        }
        return true
    }
    
    func checkEachPartLowerOrEqualMaxLength(for messages: [Message]) -> Bool {
        for message in messages {
            if message.text.count > Message.maxLenght {
                return false
            }
        }
        return true
    }
    
    func getTotalPart(from text: String) -> Int {
        let index = text.firstIndex(of: "/")!
        let startIndex = text.moveIndex(of: index, by: 1)
        let indexWhiteSpace = text.firstIndex(of: " ")!
        let totalPartString = text[startIndex..<indexWhiteSpace]
        return Int(totalPartString)!
    }
    
    func removePartIndicator(from message: Message) -> String {
        var outputText = message.text
        let indexWhiteSpace = outputText.firstIndex(of: " ")!
        outputText.replaceSubrange(outputText.startIndex...indexWhiteSpace, with: "")
        return outputText
    }
}
