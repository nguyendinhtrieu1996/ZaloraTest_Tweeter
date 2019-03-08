//
//  MessageCellViewModel.swift
//  Tweeter
//
//  Created by MACOS on 3/7/19.
//  Copyright © 2019 MACOS. All rights reserved.
//

import UIKit

class MessageCellViewModel {
    private var message: Message
    private var textBubbleLayoutModel: TextBubbleLayoutModel?
    private var cacheLayoutContext: TextBubbleLayoutModel.LayoutContext?
    
    var layoutContext: TextBubbleLayoutModel.LayoutContext {
        if cacheLayoutContext == nil {
            cacheLayoutContext = TextBubbleLayoutModel.LayoutContext(text: message.message)
        }
        return cacheLayoutContext ?? TextBubbleLayoutModel.LayoutContext()
    }
    
    init(with message: Message) {
        self.message = message
    }
    
    func calculateCellSize() -> CGSize {
        if textBubbleLayoutModel == nil {
            textBubbleLayoutModel = TextBubbleLayoutModel(layoutContext: layoutContext)
            textBubbleLayoutModel?.calculateLayout()
        }
        
        let textHeight = textBubbleLayoutModel?.size.height ?? 0
        return CGSize(width: UIScreen.main.bounds.width, height: textHeight)
    }
    
}
