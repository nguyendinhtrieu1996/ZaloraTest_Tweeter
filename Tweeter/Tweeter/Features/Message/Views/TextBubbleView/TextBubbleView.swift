//
//  TextBubbleView.swift
//  Tweeter
//
//  Created by MACOS on 3/7/19.
//  Copyright © 2019 MACOS. All rights reserved.
//

import UIKit

public final class TextBubbleView: BaseUIView {
    // MARK: Properties
    var layoutContext = TextBubbleLayoutModel.LayoutContext() {
        didSet {
            updateTextView()
            updateLayout()
        }
    }
    
    // MARK: UI Elements
    private lazy var bubbleImageView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.5734767318, green: 0.09810661525, blue: 0.7285373807, alpha: 1)
        view.layer.cornerRadius = 12
        return view
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
    
    // MARK: Helper methods
    
    private func updateTextView() {
        var needToUpdate = false
        if textView.font != layoutContext.font {
            textView.font = layoutContext.font
            needToUpdate = true
        }
        
        if textView.textColor != layoutContext.textColor {
            textView.textColor = layoutContext.textColor
            needToUpdate = true
        }
        
        if needToUpdate || textView.text != layoutContext.text {
            textView.text = layoutContext.text
        }
        
        if textView.textContainerInset != layoutContext.textInsets {
            textView.textContainerInset = layoutContext.textInsets
        }
    }
    
    private func updateLayout() {
        let layoutModel = TextBubbleLayoutModel(layoutContext: layoutContext)
        layoutModel.calculateLayout()
        textView.frame = layoutModel.textFrame
        bubbleImageView.frame = layoutModel.bubbleFrame
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

