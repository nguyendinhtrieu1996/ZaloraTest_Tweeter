//
//  StringTests.swift
//  TweeterTests
//
//  Created by MACOS on 3/10/19.
//  Copyright © 2019 MACOS. All rights reserved.
//

import XCTest
@testable import Tweeter

class StringTests: XCTestCase {
    var sut = "I can't believe Tweeter now supports chunking my messages, so I don't have to do it myself."

    override func setUp() {
    }

    override func tearDown() {
    }

}

// MATK: - Test Subscript

extension StringTests {
    func testGetSafeElementAtIndexWhenIndexOutOfRange() {
        XCTAssertNil(sut[safe: sut.endIndex])
    }
    
    func testGetSafeElementAtIndexWithValidIndex() {
        let index = sut.moveIndex(of: sut.startIndex, by: sut.count / 2)
        XCTAssertNotNil(sut[safe: index])
    }
}

// MARK: - Tests moveIndex

extension StringTests {
    func testMoveIndex_ByValueOutOfEndIndex_ReturnEndIndex() {
        let index = sut.moveIndex(of: sut.endIndex, by: 1)
        XCTAssertEqual(index, sut.endIndex)
    }
    
    func testMoveIndex_ByValueOutOfStartIndex_ReturnStartIndex() {
        let index = sut.moveIndex(of: sut.startIndex, by: -1)
        XCTAssertEqual(index, sut.startIndex)
    }
    func testMoveIndexByPositiveValue() {
        let value = 10
        let index = sut.moveIndex(of: sut.startIndex, by: value)
        let expectIndex = sut.index(sut.startIndex, offsetBy: value)
        XCTAssertEqual(index, expectIndex)
    }
    
    func testMoveIndexByNagativeValue() {
        let value = -10
        let index = sut.moveIndex(of: sut.endIndex, by: value)
        let expectIndex = sut.index(sut.endIndex, offsetBy: value)
        XCTAssertEqual(index, expectIndex)
    }
}

// MARK: - Tests addPartIndicator

extension StringTests {
    func testAddpartIndicator_WhenIndexEqualEndIndex_DoNotAdd() {
        let partIndicator = "1/2"
        let expectValue = sut
        sut.addPartIndicator(with: partIndicator, at: sut.endIndex)
        XCTAssertEqual(expectValue, sut)
    }
    
    func testAddpartIndicatiorWhenIndexInOfRange() {
        let partIndicator = "1/2"
        let expectValue = "\(partIndicator) \(sut)"
        sut.addPartIndicator(with: partIndicator, at: sut.startIndex)
        XCTAssertEqual(expectValue, sut)
    }
}

// MARK: - Tests isStopword

extension StringTests {
    func testIsStopWordAtEndIndexReturnTrue() {
        XCTAssertTrue(sut.isStopWord(sut.endIndex))
    }
    
    func testIsStopwordAtWhitespaceReturnTrue() {
        let whitespaceIndex = sut.moveIndex(of: sut.startIndex, by: 7)
        XCTAssertTrue(sut.isStopWord(whitespaceIndex))
    }
    
    func testIsStopwordWhenPreviousIndexIsWhitespaceReturnTrue() {
        let index = sut.moveIndex(of: sut.startIndex, by: 8)
        XCTAssertTrue(sut.isStopWord(index))
    }
    
    func testIsStopwordReturnFalse() {
        let index = sut.moveIndex(of: sut.startIndex, by: 9)
        XCTAssertFalse(sut.isStopWord(index))
    }
}

// MARK: - Tests findStopword

extension StringTests {
    func testFindStopWordWhenMinIndexGreaterThanStartIndex() {
        XCTAssertNil(sut.findStopWord(from: sut.startIndex, minIndex: sut.endIndex))
    }
    
    func testFindStopWordWhenStartIndexEqualMinIndex() {
        let index = sut.startIndex
        XCTAssertNil(sut.findStopWord(from: index, minIndex: index))
    }
    
    func testFindStopWordWhenStringDonotContainWhitespace() {
        let text = "sdksjkdjsjdskjdksjdksjdksjdksdjkwlew"
        XCTAssertNil(text.findStopWord(from: text.endIndex, minIndex: text.startIndex))
    }
    
    func testFindStopWord_WhenDoNotContainWhiteSpaceInRange_ReturnNil() {
        let text = "I xxxxxxxxxxxxxxx"
        let minIndex = text.moveIndex(of: text.startIndex, by: 1)
        XCTAssertNil(text.findStopWord(from: text.endIndex, minIndex: minIndex))
    }
    
    func testFindStopWordReturnIndex() {
        let text = "I can't believe Tweeter"
        let minIndex = text.moveIndex(of: text.startIndex, by: 7)
        let expectIndex = text.moveIndex(of: text.endIndex, by: -8)
        XCTAssertEqual(text.findStopWord(from: text.endIndex, minIndex: minIndex), expectIndex)
    }
}
