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
}

// MARK: -

class MessageViewModel {
    private let messages: [Message] = []
    weak var delegate: MessageViewModelDelegate?
    
    var numberMessages: Int {
        return 30
    }
    
    // MARK: Lifecycle
    
    init() {
        
    }
    
    func getMessageCellViewModel(at indexPath: IndexPath) -> MessageCellViewModel? {
        return nil
    }
    
    func keyBoardChangeFrame(_ notification: NSNotification) {
        guard let keyboardInfo = notification.getKeyboardInfo() else {
            return
        }
        delegate?.updateMessageViewBottomConstraint(with: keyboardInfo)
    }
    
}
