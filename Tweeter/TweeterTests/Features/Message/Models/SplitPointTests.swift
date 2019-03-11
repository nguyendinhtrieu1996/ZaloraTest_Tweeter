//
//  SplitPoint.swift
//  TweeterTests
//
//  Created by MACOS on 3/10/19.
//  Copyright © 2019 MACOS. All rights reserved.
//

import XCTest
@testable import Tweeter

class SplitPointTests: XCTestCase {
    let text = "1/2 I can't believe Tweeter now supports chunking"
    lazy var sut = SplitPoint(text.startIndex, text.endIndex, 1)

    override func setUp() {
    }

    override func tearDown() {
    }
    
    func testPartIndicator() {
        let currentPart = 1
        let totalPart = 2
        let expectValue = "\(currentPart)/\(totalPart)"
        XCTAssertEqual(SplitPoint.partIndicator(currentPart, totalPart), expectValue)
    }
    
    func testPartIndicatorInRange() {
        let partIndicator = "1/2"
        let expectValue = text.startIndex..<(text.moveIndex(of: text.startIndex, by: 3))
        XCTAssertEqual(sut.partIndicatorRange(in: text, partIndicator), expectValue)
    }

}
