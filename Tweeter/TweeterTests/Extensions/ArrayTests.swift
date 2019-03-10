//
//  ArrayTests.swift
//  TweeterTests
//
//  Created by MACOS on 3/10/19.
//  Copyright © 2019 MACOS. All rights reserved.
//

import XCTest
@testable import Tweeter

class ArrayTests: XCTestCase {
    private let sut = [1, 2, 3, 4, 5]

    override func setUp() {
    }

    override func tearDown() {
    }

    func testSafeGetElementAtIndex() {
        XCTAssertEqual(sut[safe: 0], sut[0])
    }
    
    func testSafeGetElementAtOutOfIndexReturnNil() {
        XCTAssertNil(sut[safe: sut.count])
    }
    
    func testSafeGetElementAtNegativeIndexReturnNil() {
        XCTAssertNil(sut[safe: -1])
    }
    
}
