//
//  MockUICollectionView.swift
//  TweeterTests
//
//  Created by Nguyen Dinh Trieu on 3/11/19.
//  Copyright © 2019 MACOS. All rights reserved.
//

import UIKit
@testable import Tweeter

class MockUICollectionView: UICollectionView {
    var wasCallReloadData = false
    var wasCallScrollToItem = false
    var wasCallDequeue = false
    
    class func initMockUICollectionView(with dataSource: UICollectionViewDataSource) -> MockUICollectionView {
        let collectionView = MockUICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.dataSource = dataSource
        collectionView.reloadData()
        return collectionView
    }
    
    override func reloadData() {
        wasCallReloadData = true
        super.reloadData()
    }
    
    override func dequeueReusableCell(withReuseIdentifier identifier: String, for indexPath: IndexPath) -> UICollectionViewCell {
        wasCallDequeue = true
        return super.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
    }
    
    override func scrollToItem(at indexPath: IndexPath, at scrollPosition: UICollectionView.ScrollPosition, animated: Bool) {
        wasCallScrollToItem = true
        super.scrollToItem(at: indexPath, at: scrollPosition, animated: true)
    }
    
}
