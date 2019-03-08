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
    
    @IBOutlet fileprivate weak var messageCollectionView: UICollectionView?
    @IBOutlet fileprivate weak var inputMessageView: InputMessageView?
    
    // MARK: Constraints
    
    @IBOutlet fileprivate weak var inputMessageViewHeightConst: NSLayoutConstraint?
    @IBOutlet fileprivate weak var inputMessageViewBottomConst: NSLayoutConstraint?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNotification()
        setupNavigationBar()
        setupMessageCollectionView()
        inputMessageView?.delegate = messageViewModel
    }
    
    // MARK: SetupView
    
    private func setupNavigationBar() {
        title = "Tweeter Chat"
    }
    
    private func setupMessageCollectionView() {
        messageCollectionView?.registerReusableCell(MessageCollectionViewCell.self)
       
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

// MARK: - UICollectionViewDataSource

extension MessageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messageViewModel.numberMessages
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MessageCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        guard let messageCellViewModel = messageViewModel.getMessageCellViewModel(at: indexPath) else {
            return cell
        }
        cell.setupData(with: messageCellViewModel)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MessageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let messageCellViewModel = messageViewModel.getMessageCellViewModel(at: indexPath) else {
            return CGSize.zero
        }
        return messageCellViewModel.calculateCellSize()
    }
}

// MARK: - MessageViewModelDelegate

extension MessageViewController: MessageViewModelDelegate {
    func shoudClearInputText() {
        inputMessageView?.clearInputText()
    }
    
    func reloadData() {
        messageCollectionView?.reloadData()
    }
    
    func updateSendButtonState(isEnable: Bool) {
        inputMessageView?.updateSendButtonState(isEnable: isEnable)
    }
    
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
