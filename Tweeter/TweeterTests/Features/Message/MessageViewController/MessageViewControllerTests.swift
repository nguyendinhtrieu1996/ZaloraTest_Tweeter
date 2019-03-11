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
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "MessageViewController")
        sut = viewController as! MessageViewController
        sut.loadViewIfNeeded()
        collectionView = sut.messageCollectionView!
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
    func testLoadViewAndSetNavigationBarTitle() {
        let title = sut.title
        XCTAssertEqual(title, "Tweeter Chat")
    }
    
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

// MARK: - Tests Notification

extension MessageViewControllerTests {
    func testViewModel_WhenSystemPostNoti_CallKeyBoardChangeFrame() {
        let mockViewModel = MockMessageViewModel()
        sut.messageViewModel = mockViewModel
        NotificationCenter.default.post(name: UIResponder.keyboardWillChangeFrameNotification,
                                        object: nil,
                                        userInfo: nil)
        XCTAssertTrue(mockViewModel.wasCallKeyboardChangeFrame)
    }
}

// MARK: - Test UICollectionViewDataSource

extension MessageViewControllerTests {
    func testNumberOfSectionReturn1() {
        XCTAssertEqual(sut.messageCollectionView?.numberOfSections, 1)
    }
    
    func testNumberOfMessageWithNoneMessageReturn0() {
        XCTAssertEqual(sut.messageCollectionView?.numberOfItems(inSection: 0), viewModel.numberMessages)
    }
    
    func testCellForRowReturnMessageCollectionViewCell() {
        let cell = sut.collectionView(sut.messageCollectionView!, cellForItemAt: IndexPath(row: 0, section: 0))
        XCTAssertTrue(cell is MessageCollectionViewCell)
    }
    
    func testCellForRow_WhenIndexPathOutOfRange_ReturnMessageCollectionViewCell() {
        let cell = sut.collectionView(sut.messageCollectionView!, cellForItemAt: IndexPath(row: 1, section: 0))
        XCTAssertTrue(cell is MessageCollectionViewCell)
    }
    
    func testCellForRowCallConfigCell() {
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 320, height: 400),
                                              collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(MockMessageCollectionViewCell.self,
                                forCellWithReuseIdentifier: "MessageCollectionViewCell")
        setupMessageViewModel()
        collectionView.dataSource = sut
        collectionView.reloadData()
        let cell = sut.collectionView(collectionView, cellForItemAt: IndexPath(row: 0, section: 0)) as! MockMessageCollectionViewCell
        XCTAssertTrue(cell.wasCallConfigure)
    }
}

// MARK: - Tests UICollectionViewDelegateFlowLayout

extension MessageViewControllerTests {
    func testMinimumLineSpacing() {
        let spacing = sut.collectionView(collectionView,
                                         layout: collectionView.collectionViewLayout,
                                         minimumLineSpacingForSectionAt: 0)
        XCTAssertEqual(spacing, 6)
    }
    
    func testSizeForItemReturnSizeEqualCellViewModelSize() {
        setupMessageViewModel()
        let size = sut.collectionView(collectionView,
                                      layout: collectionView.collectionViewLayout,
                                      sizeForItemAt: IndexPath(row: 0, section: 0))
        let expectedSize = viewModel.viewModelForCell(at: 0)?.calculateCellSize()
        XCTAssertEqual(size, expectedSize)
    }
    
    func testSizeForItemWhenIndexOutOfRangeReturnZero() {
        setupMessageViewModel()
        let size = sut.collectionView(collectionView,
                                      layout: collectionView.collectionViewLayout,
                                      sizeForItemAt: IndexPath(row: 1, section: 0))
        XCTAssertEqual(size, .zero)
    }
    
}

//MARK: - Tests MessageViewModelDelegate Protocol

extension MessageViewControllerTests {
    func testUpdateLayoutSendMessageSuccess_CallCollectionViewReloadData() {
        setupMessageViewModel()
        let mockCollectionView = MockUICollectionView.initMockUICollectionView(with: sut)
        sut.messageCollectionView = mockCollectionView
        sut.updateLayoutSendMessageSuccess()
        XCTAssertTrue(mockCollectionView.wasCallReloadData)
    }
    
    func testUpdateLayoutSendMessageSuccess_CallCollectionViewScrollToItem() {
        setupMessageViewModel()
        let mockCollectionView = MockUICollectionView.initMockUICollectionView(with: sut)
        sut.messageCollectionView = mockCollectionView
        sut.updateLayoutSendMessageSuccess()
        XCTAssertTrue(mockCollectionView.wasCallScrollToItem)
    }
    
    func testUpdateLayoutSendMessageSuccess_CallClearTextField() {
        setupMessageViewModel()
        let mockInputMessage = MockInputMessageView()
        sut.inputMessageView = mockInputMessage
        sut.updateLayoutSendMessageSuccess()
        XCTAssertTrue(mockInputMessage.wasCalledClearInputText)
    }
    
    func testUpdateLayoutSendMessageSuccess_CallUpdateStateSendButtonWithFalseValue() {
        setupMessageViewModel()
        let mockInputMessage = MockInputMessageView()
        sut.inputMessageView = mockInputMessage
        sut.updateLayoutSendMessageSuccess()
        XCTAssertTrue(mockInputMessage.wasCalledUpdateSendButtonState)
        XCTAssertFalse(mockInputMessage.sendButton!.isEnabled)
    }
    
    func testUpdateSendButtonState_CallInputMessageViewUpdateStateButton() {
        setupMessageViewModel()
        let mockInputMessage = MockInputMessageView()
        sut.inputMessageView = mockInputMessage
        sut.updateSendButtonState(isEnable: true)
        XCTAssertTrue(mockInputMessage.wasCalledUpdateSendButtonState)
    }
    
    func testUpdateMessageViewBottomConstraint_UpdateConstraintMessageView() {
        let keyboardInfo = KeyboardAnimationInfo(constraint: 300, duration: 1.0, option: .allowUserInteraction)
        sut.updateMessageViewBottomConstraint(with: keyboardInfo)
        XCTAssertEqual(sut.inputMessageViewBottomConst?.constant, -keyboardInfo.constraint)
    }
    
}
