//
//  CGSizeTests.swift
//  TweeterTests
//
//  Created by MACOS on 3/10/19.
//  Copyright © 2019 MACOS. All rights reserved.
//

import XCTest
@testable import Tweeter

class CGSizeTests: XCTestCase {

    override func setUp() {
    }

    override func tearDown() {
    }

}

// MARK: - Tests outsetBy

extension CGSizeTests {
    func testOutsetByReturnCorrectValue() {
        let size = CGSize(width: 100, height: 100)
        let expectSize = CGSize(width: 110, height: 120)
        let dx: CGFloat = 10
        let dy: CGFloat = 20
        XCTAssertEqual(size.outsetBy(dx: dx, dy: dy), expectSize)
    }
}
