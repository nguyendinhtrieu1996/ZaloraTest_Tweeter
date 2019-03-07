//
//  MessageTableViewCell.swift
//  Tweeter
//
//  Created by MACOS on 3/7/19.
//  Copyright © 2019 MACOS. All rights reserved.
//

import UIKit

class MessageTableViewCell: BaseUITableViewCell {
    @IBOutlet weak var textBubbleView: TextBubbleView?

    override func initialize() {
        
    }
    
    func setupMessage(message: String) {
        let textBubbleStyle = TextBubbleStyle(text: message)
        textBubbleView?.style = textBubbleStyle
        textBubbleView?.layoutSubviews()
    }
    
}
