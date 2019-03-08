//
//  MessageViewModel.swift
//  Tweeter
//
//  Created by MACOS on 3/6/19.
//  Copyright © 2019 MACOS. All rights reserved.
//

import Foundation

protocol MessageViewModelDelegate: class {
    func updateMessageViewBottomConstraint(with keyboardInfo: KeyboardAnimationInfo)
    func updateSendButtonState(isEnable: Bool)
    func reloadData()
    func shoudClearInputText()
}

// MARK: -

class MessageViewModel {
    fileprivate var messages: [Message] = []
    weak var delegate: MessageViewModelDelegate?
    
    var numberMessages: Int {
        return messages.count
    }
    
    // MARK: Lifecycle
    
    init() {
    }
    
    func getMessageCellViewModel(at indexPath: IndexPath) -> MessageCellViewModel? {
        guard let message = messages[safe: indexPath.row] else {
            return nil
        }
        return MessageCellViewModel(with: message)
    }
    
    func keyBoardChangeFrame(_ notification: NSNotification) {
        guard let keyboardInfo = notification.getKeyboardInfo() else {
            return
        }
        delegate?.updateMessageViewBottomConstraint(with: keyboardInfo)
    }
    
}

// MARK: - InputMessageViewDelegate

extension MessageViewModel: InputMessageViewDelegate {
    func didSelectSendButton(with message: String) {
        let message = Message(text: message)
        messages.append(message)
        delegate?.reloadData()
        delegate?.shoudClearInputText()
    }
    
    func inputTextValueChange(with text: String?) {
        if text == nil || text == "" {
            delegate?.updateSendButtonState(isEnable: false)
        } else {
            delegate?.updateSendButtonState(isEnable: true)
        }
    }
}
