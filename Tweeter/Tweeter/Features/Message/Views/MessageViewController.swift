//
//  ViewController.swift
//  Tweeter
//
//  Created by MACOS on 3/6/19.
//  Copyright © 2019 MACOS. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController {
    
    // MARK: Properties
    
    fileprivate lazy var messageViewModel: MessageViewModel = {
        let viewModel = MessageViewModel()
        viewModel.delegate = self
        return viewModel
    }()
    
    // MARK: UI Elements
    
    @IBOutlet fileprivate weak var messageTableView: UITableView?
    @IBOutlet fileprivate weak var inputMessageView: InputMessageView?
    
    // MARK: Constraints
    
    @IBOutlet fileprivate weak var inputMessageViewHeightConst: NSLayoutConstraint?
    @IBOutlet fileprivate weak var inputMessageViewBottomConst: NSLayoutConstraint?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNotification()
        setupNavigationBar()
        setupMessageTableView()
    }
    
    // MARK: SetupView
    
    private func setupNavigationBar() {
        
    }
    
    private func setupMessageTableView() {
        messageTableView?.registerReusableCell(MessageTableViewCell.self)
        messageTableView?.separatorStyle = .none
        messageTableView?.dataSource = self
        messageTableView?.delegate = self
    }
    
    // MARK: Helper methods
    
    @objc private func handleKeyboardNotification(_ notification: NSNotification) {
        messageViewModel.keyBoardChangeFrame(notification)
    }
    
    private func registerNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleKeyboardNotification(_:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
    }
    
}

// MARK: - UITableViewDelegate

extension MessageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let text = "Chatto is a Swift lightweight framework to build chat applications. It's been designed to be extensible and performant. Along with Chatto there is ChattoAdditions"
        let style = TextBubbleLayoutModel.LayoutContext(
            text: text,
            font: Dimension.shared.defaultMessageFont,
            textInsets: Dimension.shared.defaultMessageInsets,
            preferedMaxLayoutWidth: Dimension.shared.bubbleViewMaxLayoutWith)
        let x = TextBubbleLayoutModel(layoutContext: style)
        x.calculateLayout()
        return x.size.height
    }
}

// MARK: - UITableViewDataSource

extension MessageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MessageTableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
        cell.setupMessage(message: "Chatto is a Swift lightweight framework to build chat applications. It's been designed to be extensible and performant. Along with Chatto there is ChattoAdditions")
        return cell
    }
}

// MARK: - MessageViewModelDelegate

extension MessageViewController: MessageViewModelDelegate {
    func updateMessageViewBottomConstraint(with keyboardInfo: KeyboardAnimationInfo) {
        inputMessageViewBottomConst?.constant = -keyboardInfo.constraint
        
        UIView.animateKeyframes(withDuration: keyboardInfo.duration,
                                delay: 0,
                                options: keyboardInfo.option,
                                animations:
            { [weak self] in
                self?.view.layoutIfNeeded()
            }, completion: nil)
    }
}
