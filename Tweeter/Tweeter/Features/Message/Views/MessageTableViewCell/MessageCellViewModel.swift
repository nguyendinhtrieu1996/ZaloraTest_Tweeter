//
//  MessageCellViewModel.swift
//  Tweeter
//
//  Created by MACOS on 3/7/19.
//  Copyright © 2019 MACOS. All rights reserved.
//

import UIKit

protocol MessageCellViewModelProtocol {
    
}

// MARK: -

class MessageCellViewModel {
    private var message = Message()
    private (set) var messageWith: CGFloat = 0
    private (set) var messageHeight: CGFloat = 0
    
    var text: String {
        return message.text
    }
    
    init(with message: Message) {
        self.message = message
    }
    
}
