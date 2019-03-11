//
//  MessageCellViewModelTests.swift
//  TweeterTests
//
//  Created by MACOS on 3/10/19.
//  Copyright © 2019 MACOS. All rights reserved.
//

import XCTest
@testable import Tweeter

class MessageCellViewModelTests: XCTestCase {
    let message = Message(text: "1/2 I can't believe Tweeter now supports chunking")
    lazy var sut = MessageCellViewModel(with: message)

    override func setUp() {
    }

    override func tearDown() {
    }
    
    func testCalculateCellSize_ReturnSizeFromBubbleLayout() {
        let layoutContext = TextBubbleLayoutModel.LayoutContext(text: message.text)
        let layoutModel = TextBubbleLayoutModel(layoutContext: layoutContext)
        layoutModel.calculateLayout()
        let expectSize = CGSize(width: UIScreen.main.bounds.width, height: layoutModel.size.height)
        XCTAssertEqual(sut.calculateCellSize(), expectSize)
    }
    
    func testLayoutContext() {
        let layoutContext = TextBubbleLayoutModel.LayoutContext(text: message.text)
        XCTAssertEqual(layoutContext, sut.layoutContext)
    }
    
}
