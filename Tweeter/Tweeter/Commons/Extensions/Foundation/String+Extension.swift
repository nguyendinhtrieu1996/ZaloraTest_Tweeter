//
//  String+Extension.swift
//  Tweeter
//
//  Created by MACOS on 3/6/19.
//  Copyright © 2019 MACOS. All rights reserved.
//

import Foundation

public extension String {
    
    func moveForward(currentIndex: Index, value: Int) -> Index {
        if distance(from: currentIndex, to: endIndex) <= value {
            return endIndex
        }
        return index(currentIndex, offsetBy: value)
    }
    
    func moveBackward(currentIndex: Index, value: Int) -> Index {
        if distance(from: startIndex, to: currentIndex) <= value {
            return startIndex
        }
        return index(currentIndex, offsetBy: -value)
    }
    
    mutating func addPartIndicator(with partIndicator: String, at index: Index, endIndex: Index) -> Bool {
        let needMoveEndIndex = (endIndex == self.endIndex)
        var indicator = partIndicator
        
        if self[index] != " " {
            indicator += " "
        }
        insert(contentsOf: indicator, at: index)
        return needMoveEndIndex
    }
    
    func isStopWord(index: Index) -> Bool {
        if index == endIndex {
            return true
        }
        let nextIndex = moveForward(currentIndex: index, value: 1)
        if self[nextIndex] == " " || self[index] == " " {
            return true
        }
        return false
    }
    
    func findStopWord(from index: Index, minIndex: Index) -> Index? {
        var currentIndex = index
        while currentIndex >= minIndex {
            if self[currentIndex] == " " {
                return currentIndex
            }
            currentIndex = moveBackward(currentIndex: currentIndex, value: 1)
        }
    
        return nil
    }
    
}
