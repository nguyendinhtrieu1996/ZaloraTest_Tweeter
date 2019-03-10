//
//  UIEdgeInsetsTests.swift
//  TweeterTests
//
//  Created by MACOS on 3/10/19.
//  Copyright © 2019 MACOS. All rights reserved.
//

import XCTest
@testable import Tweeter

class UIEdgeInsetsTests: XCTestCase {
    override func setUp() {
    }

    override func tearDown() {
    }
    
    func testHorizontalInsets() {
        let left: CGFloat = 10
        let right: CGFloat = 20
        let insets = UIEdgeInsets(top: 10, left: left, bottom: 0, right: right)
        let expectHorizontallInsets = left + right
        XCTAssertEqual(insets.horizontalInsets, expectHorizontallInsets)
    }

    func testVerticalInsets() {
        let top: CGFloat = 10
        let bottom: CGFloat = 20
        let insets = UIEdgeInsets(top: top, left: 10, bottom: bottom, right: 10)
        let expectVerticalInsets = top + bottom
        XCTAssertEqual(insets.vericalInsets, expectVerticalInsets)
    }
    
}
