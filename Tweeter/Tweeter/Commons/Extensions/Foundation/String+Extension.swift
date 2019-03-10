//
//  String+Extension.swift
//  Tweeter
//
//  Created by MACOS on 3/6/19.
//  Copyright © 2019 MACOS. All rights reserved.
//

import Foundation

public extension String {
    func moveIndex(of currentIndex: Index, by value: Int) -> Index {
        if value >= 0 {
            if distance(from: currentIndex, to: endIndex) <= value {
                return endIndex
            }
        } else {
            if distance(from: startIndex, to: currentIndex) <= value {
                return startIndex
            }
        }
        return index(currentIndex, offsetBy: value)
    }
    
    mutating func addPartIndicator(with partIndicator: String, at index: Index) {
        var indicator = partIndicator

        if self[index] != " " {
            indicator += " "
        }
        insert(contentsOf: indicator, at: index)
    }
    
    func isStopWord(_ endPartIndex: Index) -> Bool {
        if endPartIndex == endIndex {
            return true
        }
        let previousIndex = moveIndex(of: endPartIndex, by: -1)
        if self[previousIndex] == " " || self[endPartIndex] == " " || self[previousIndex] == "." {
            return true
        }
        return false
    }
    
    func findStopWord(from index: Index, minIndex: Index) -> Index? {
        var currentIndex = index
        while currentIndex > minIndex {
            if self[currentIndex] == " " {
                return currentIndex
            }
            currentIndex = moveIndex(of: currentIndex, by: -1)
        }
    
        return nil
    }
    
}
