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
        let text: String
        let font: UIFont
        let textInsets: UIEdgeInsets
        let preferedMaxLayoutWidth: CGFloat
    }
    
    // MARK: Properties
    
    private (set) var layoutContext: LayoutContext
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
    
    func textSizeThatFitsWidth(_ width: CGFloat) -> CGSize {
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
