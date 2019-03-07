//
//  TextBubbleView.swift
//  Tweeter
//
//  Created by MACOS on 3/7/19.
//  Copyright © 2019 MACOS. All rights reserved.
//

import UIKit

public class TextBubbleStyle {
    private (set) var text = ""
    private (set) var font: UIFont = Dimension.shared.defaultMessageFont
    private (set) var textColor: UIColor = Theme.shared.defaultTextColor
    private (set) var textInsets = Dimension.shared.defaultMessageInsets
    
    init() {
    }
    
    init(text: String,
         font: UIFont = Dimension.shared.defaultMessageFont,
         textColor: UIColor = Theme.shared.defaultTextColor,
         textInsets: UIEdgeInsets = Dimension.shared.defaultMessageInsets ) {
        self.text = text
        self.font = font
        self.textColor = textColor
    }
    
}

// MARK: -

public final class TextBubbleView: BaseUIView {
    // MARK: Properties
    public var preferredMaxLayoutWidth: CGFloat = Dimension.shared.bubbleViewMaxLayoutWith
    
    var style = TextBubbleStyle() {
        didSet {
            updateTextView()
        }
    }
    
    // MARK: UI Elements
    private lazy var bubbleImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private var textView: UITextView = {
        let textView = ChatMessageTextView()
        UIView.performWithoutAnimation({ () -> Void in
            textView.backgroundColor = UIColor.clear
        })
        textView.isEditable = false
        textView.isSelectable = true
        textView.dataDetectorTypes = .all
        textView.scrollsToTop = false
        textView.isScrollEnabled = false
        textView.bounces = false
        textView.bouncesZoom = false
        textView.showsHorizontalScrollIndicator = false
        textView.showsVerticalScrollIndicator = false
        textView.isExclusiveTouch = true
        textView.textContainer.lineFragmentPadding = 0
        return textView
    }()
    
    // MARK: Lifecycle
    
    override public func initialize() {
        addSubview(bubbleImageView)
        addSubview(textView)
    }
    
    // MARK: Layout
    
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        return self.calculateTextBubbleLayout(preferredMaxLayoutWidth: size.width).size
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        let layout = calculateTextBubbleLayout(preferredMaxLayoutWidth: preferredMaxLayoutWidth)
        textView.frame = layout.textFrame
        bubbleImageView.frame = layout.bubbleFrame
    }
    
    private func calculateTextBubbleLayout(preferredMaxLayoutWidth: CGFloat) -> TextBubbleLayoutModel {
        let layoutContext = TextBubbleLayoutModel.LayoutContext(
            text: style.text,
            font: style.font,
            textInsets: style.textInsets,
            preferedMaxLayoutWidth: preferredMaxLayoutWidth)
        
        let layoutModel = TextBubbleLayoutModel(layoutContext: layoutContext)
        layoutModel.calculateLayout()
        return layoutModel
    }
    
    // MARK: Helper methods
    
    private func updateTextView() {
        var needToUpdate = false
        if textView.font != style.font {
            textView.font = style.font
            needToUpdate = true
        }
        
        if textView.textColor != style.textColor {
            textView.textColor = style.textColor
            needToUpdate = true
        }
        
        if needToUpdate || textView.text != style.text {
            textView.text = style.text
        }
        
        if textView.textContainerInset != style.textInsets {
            textView.textContainerInset = style.textInsets
        }
    }
    
}

// MARK: -

private final class ChatMessageTextView: UITextView {
    
    override var canBecomeFirstResponder: Bool {
        return false
    }
    
    override var gestureRecognizers: [UIGestureRecognizer]? {
        set {
            super.gestureRecognizers = newValue
        }
        get {
            return super.gestureRecognizers?.filter({ (gestureRecognizer) -> Bool in
                return type(of: gestureRecognizer) == UILongPressGestureRecognizer.self && gestureRecognizer.delaysTouchesEnded
            })
        }
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
    
    override var selectedRange: NSRange {
        get {
            return NSRange(location: 0, length: 0)
        }
        set {
        }
    }
    
    override var contentOffset: CGPoint {
        get {
            return .zero
        }
        set {
        }
    }
}

