//
//  UIViewTests.swift
//  TweeterTests
//
//  Created by MACOS on 3/10/19.
//  Copyright © 2019 MACOS. All rights reserved.
//

import XCTest
@testable import Tweeter

class UIViewTests: XCTestCase {
    override func setUp() {
    }

    override func tearDown() {
    }

    func testUIViewFrameWidthAndHeight() {
        let width: CGFloat = 100
        let height: CGFloat = 150
        let view = UIView()
        view.frame = CGRect(x: 19, y: 20, width: width, height: height)
        XCTAssertEqual(view.frameWidth, width)
        XCTAssertEqual(view.frameHeight, height)
    }
}
