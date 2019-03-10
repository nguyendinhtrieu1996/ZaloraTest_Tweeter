//
//  MessageViewControllerTests.swift
//  TweeterTests
//
//  Created by MACOS on 3/10/19.
//  Copyright © 2019 MACOS. All rights reserved.
//

import XCTest
@testable import Tweeter

class MessageViewControllerTests: XCTestCase {
    var sut = MessageViewController()
    var viewModel = MessageViewModel(with: [])

    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "MessageViewController")
        sut = viewController as! MessageViewController
        sut.loadViewIfNeeded()
    }

    override func tearDown() {
    }
    
    func setupMessageViewModel() {
        let message = Message(text: "I can't believe Tweeter now supports chunking my messages")
        viewModel = MessageViewModel(with: [message])
        sut.messageViewModel = viewModel
        sut.messageCollectionView?.reloadData()
    }
    
}

// MARK: - Tests when load view

extension MessageViewControllerTests {
    func testMessageCollectionViewNotNilAfterViewDidLoad() {
        XCTAssertNotNil(sut.messageCollectionView)
    }
    
    func testInputMessageViewNotNilAfterViewDidload() {
        XCTAssertNotNil(sut.inputMessageView)
    }
    
    func testLoadViewSetCollectionViewDelegate() {
        XCTAssertTrue(sut.messageCollectionView?.delegate is MessageViewController)
    }
    
    func testLoadViewSetCollectionViewDataSource() {
        XCTAssertTrue(sut.messageCollectionView?.dataSource is MessageViewController)
    }
    
    func testLoadViewSetInputMessageViewDelegate() {
        XCTAssertTrue(sut.inputMessageView?.delegate is MessageViewModel)
    }
    
    func testLoadViewSetEdgeInsetsForCollectionView() {
        let expectedInsets = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
        XCTAssertEqual(sut.messageCollectionView?.contentInset, expectedInsets)
    }
}

// MARK: - Test UICollectionViewDataSource

extension MessageViewControllerTests {
    func testNumberOfSectionReturn1() {
        XCTAssertEqual(sut.messageCollectionView?.numberOfSections, 1)
    }
    
    func testNumberOfMessageWithNoneMessageReturn0() {
        setupMessageViewModel()
        XCTAssertEqual(sut.messageCollectionView?.numberOfItems(inSection: 0), viewModel.numberMessages)
    }
    
    func testCellForRowReturnMessageCollectionViewCell() {
        setupMessageViewModel()
        let cell = sut.collectionView(sut.messageCollectionView!, cellForItemAt: IndexPath(row: 0, section: 0))
        XCTAssertTrue(cell is MessageCollectionViewCell)
    }
    
    func testCellForRow_WhenIndexPathOutOfRange_ReturnMessageCollectionViewCell() {
        setupMessageViewModel()
        let cell = sut.collectionView(sut.messageCollectionView!, cellForItemAt: IndexPath(row: 1, section: 0))
        XCTAssertTrue(cell is MessageCollectionViewCell)
    }
    
    func testCellForRowCallConfigCell() {
        let mockCollectionView = MockUICollectionView()
        mockCollectionView.registerReusableCell(MockMessageCollectionViewCell.self)
        mockCollectionView.dataSource = sut
        setupMessageViewModel()
        mockCollectionView.reloadData()
        let cell = mockCollectionView.cellForItem(at: IndexPath(row: 0, section: 0)) as! MockMessageCollectionViewCell
        XCTAssertTrue(cell.wasCallConfigure)
    }
    
}
