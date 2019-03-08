//
//  TextBubbleLayoutModel.swift
//  Tweeter
//
//  Created by MACOS on 3/7/19.
//  Copyright © 2019 MACOS. All rights reserved.
//

import UIKit

final class TextBubbleLayoutModel {
    // MARK: Helper Type
    
    struct LayoutContext: Equatable {
        var text: String = ""
        var font: UIFont = Dimension.shared.defaultMessageFont
        var textColor: UIColor = Theme.shared.defaultTextColor
        var textInsets: UIEdgeInsets = Dimension.shared.defaultMessageInsets
        var preferedMaxLayoutWidth: CGFloat = Dimension.shared.bubbleViewMaxLayoutWith
        
        init() {
        }
        
        init(text: String) {
            self.text = text
        }
        
        init(text: String,
             font: UIFont,
             textColor: UIColor,
             textInsets: UIEdgeInsets,
             preferedMaxLayoutWidth: CGFloat) {
            self.text = text
            self.font = font
            self.textColor = textColor
            self.textInsets = textInsets
            self.preferedMaxLayoutWidth = preferedMaxLayoutWidth
        }
    }
    
    // MARK: Properties
    
    private var layoutContext: LayoutContext
    private (set) var textFrame = CGRect.zero
    private (set) var bubbleFrame = CGRect.zero
    private (set) var size = CGSize.zero
    
    init(layoutContext: LayoutContext) {
        self.layoutContext = layoutContext
    }
    
    // MARK: Helper methods
    
    func calculateLayout() {
        let textHorizontalInset = layoutContext.textInsets.horizontalInsets
        let maxTextWidth = layoutContext.preferedMaxLayoutWidth - textHorizontalInset
        let textSize = textSizeThatFitsWidth(maxTextWidth)
        let bubbleSize = textSize.outsetBy(dx: textHorizontalInset, dy: layoutContext.textInsets.vericalInsets)
        
        bubbleFrame = CGRect(origin: .zero, size: bubbleSize)
        textFrame = bubbleFrame
        size = bubbleSize
    }
    
    private func textSizeThatFitsWidth(_ width: CGFloat) -> CGSize {
        let textContainer: NSTextContainer = {
            let size = CGSize(width: width, height: .greatestFiniteMagnitude)
            let container = NSTextContainer(size: size)
            container.lineFragmentPadding = 0
            return container
        }()
        
        let textStorage = replaceUITextViewNSTextStorage()
        let layoutManager: NSLayoutManager = {
            let layoutManager = NSLayoutManager()
            layoutManager.addTextContainer(textContainer)
            textStorage.addLayoutManager(layoutManager)
            return layoutManager
        }()
        
        let rect = layoutManager.usedRect(for: textContainer)
        
        return rect.size
    }
    
    private func replaceUITextViewNSTextStorage() -> NSTextStorage {
        return NSTextStorage(
            string: layoutContext.text,
            attributes: [
                NSAttributedString.Key.font: layoutContext.font,
                NSAttributedString.Key(rawValue: "NSOriginalFont"): layoutContext.font
            ]
        )
    }
    
}
