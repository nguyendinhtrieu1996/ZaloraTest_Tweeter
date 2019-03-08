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
    func updateLayoutSendMessageSuccess()
}

// MARK: -

class MessageViewModel {
    fileprivate var messages: [Message] = []
    weak var delegate: MessageViewModelDelegate?
    
    var numberMessages: Int {
        return messages.count
    }
    
    var lastMessageIndexPath: IndexPath {
        return IndexPath(row: numberMessages - 1, section: 0)
    }
    
    init() {
    }
    
    func getMessageCellViewModel(at index: Int) -> MessageCellViewModel? {
        guard let message = messages[safe: index] else {
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
        guard let subMessages = Message.splitMessage(message) else {
            return
        }
        subMessages.forEach {
            messages.append($0)
        }
        delegate?.updateLayoutSendMessageSuccess()
    }
    
    func inputTextValueChange(with text: String?) {
        if text == nil || text == "" {
            delegate?.updateSendButtonState(isEnable: false)
        } else {
            delegate?.updateSendButtonState(isEnable: true)
        }
    }
}
