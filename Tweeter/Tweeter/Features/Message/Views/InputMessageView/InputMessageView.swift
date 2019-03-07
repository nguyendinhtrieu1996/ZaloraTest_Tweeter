//
//  InputMessageView.swift
//  Tweeter
//
//  Created by MACOS on 3/7/19.
//  Copyright © 2019 MACOS. All rights reserved.
//

import UIKit

class InputMessageView: BaseXibView, Reusable {
    
    // MARK: Properties
    
    // MARK: UI Elements
    
    @IBOutlet weak var containerView: InputMessageView?
    @IBOutlet weak var inputMessageTextView: UITextView?
    @IBOutlet weak var sendButton: UIButton?
    
    // MARK: Lifecycle
    
    override func initialize() {
        Bundle.main.loadNibNamed(InputMessageView.reuseIdentifier, owner: self, options: nil)
        commonInit(view: containerView)
        layoutIfNeeded()
        setupViewInputMessageTextView()
    }
    
    private func setupViewInputMessageTextView() {
        let height = inputMessageTextView?.frameHeight ?? 0
        inputMessageTextView?.layer.cornerRadius = height / 2
        inputMessageTextView?.layer.masksToBounds = true
    }
    
}
