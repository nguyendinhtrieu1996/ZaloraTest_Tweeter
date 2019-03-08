//
//  MessageCollectionViewCell.swift
//  Tweeter
//
//  Created by Nguyen Dinh Trieu on 3/8/19.
//  Copyright © 2019 MACOS. All rights reserved.
//

import UIKit

class MessageCollectionViewCell: BaseUICollectiionCell {
    private var viewModel = MessageCellViewModel(with: Message(text: ""))
    @IBOutlet weak var textBubbleView: TextBubbleView?
    
    override func initialize() {
        
    }
    
    func setupData(with viewModel: MessageCellViewModel) {
        self.viewModel = viewModel
        textBubbleView?.layoutContext = viewModel.layoutContext
    }

}
