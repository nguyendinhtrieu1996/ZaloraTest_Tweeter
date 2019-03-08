//
//  BaseUICollectionView.swift
//  Tweeter
//
//  Created by Nguyen Dinh Trieu on 3/8/19.
//  Copyright © 2019 MACOS. All rights reserved.
//

import UIKit

class BaseUICollectiionCell: UICollectionViewCell, Reusable, ReusableView {
    override func awakeFromNib() {
        super.awakeFromNib()
        initialize()
    }
    
    func initialize() {
    }
}
