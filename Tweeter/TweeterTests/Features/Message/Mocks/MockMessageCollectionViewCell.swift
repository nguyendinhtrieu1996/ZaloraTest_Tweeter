//
//  MockMessageCollectionViewCell.swift
//  TweeterTests
//
//  Created by MACOS on 3/10/19.
//  Copyright © 2019 MACOS. All rights reserved.
//

@testable import Tweeter

class MockMessageCollectionViewCell: MessageCollectionViewCell {
    var wasCallConfigure = false
    
    override func configure(with viewModel: MessageCellViewModel) {
        wasCallConfigure = true
        super.configure(with: viewModel)
    }
    
}
