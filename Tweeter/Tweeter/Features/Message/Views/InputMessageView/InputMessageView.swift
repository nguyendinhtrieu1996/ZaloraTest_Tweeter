//
//  InputMessageView.swift
//  Tweeter
//
//  Created by MACOS on 3/7/19.
//  Copyright © 2019 MACOS. All rights reserved.
//

import UIKit

protocol InputMessageViewDelegate: class {
    func didSelectSendButton(with message: String)
    func inputTextValueChange(with text: String?)
}

class InputMessageView: BaseXibView, Reusable {
    
    // MARK: Properties
    
    weak var delegate: InputMessageViewDelegate?
    
    // MARK: UI Elements
    
    @IBOutlet private weak var containerView: InputMessageView?
    @IBOutlet private weak var inputMessageTextView: UITextView?
    @IBOutlet private weak var sendButton: UIButton?
    
    // MARK: Lifecycle
    
    override func initialize() {
        Bundle.main.loadNibNamed(InputMessageView.reuseIdentifier, owner: self, options: nil)
        commonInit(view: containerView)
        inputMessageTextView?.delegate = self
        inputMessageTextView?.layer.cornerRadius = 17
        inputMessageTextView?.layer.masksToBounds = true
    }
    
    @IBAction func tappedOnSendButton(_ sender: Any) {
        guard let text = inputMessageTextView?.text else {
            return
        }
        delegate?.didSelectSendButton(with: text)
    }
    
    func updateSendButtonState(isEnable: Bool) {
        sendButton?.isEnabled = isEnable
    }
    
    func clearInputText() {
        inputMessageTextView?.text = nil
    }
    
}

// MARK: - UITextViewDelegate

extension InputMessageView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        delegate?.inputTextValueChange(with: textView.text)
    }
}
