//
//  BaseUITableViewCell.swift
//  Tweeter
//
//  Created by MACOS on 3/6/19.
//  Copyright © 2019 MACOS. All rights reserved.
//

import UIKit

class BaseUITableViewCell: UITableViewCell, Reusable, ReusableView {
    override func awakeFromNib() {
        super.awakeFromNib()
        layoutIfNeeded()
        selectionStyle = .none
        initialize()
    }
    
    func initialize() {
    }
}
