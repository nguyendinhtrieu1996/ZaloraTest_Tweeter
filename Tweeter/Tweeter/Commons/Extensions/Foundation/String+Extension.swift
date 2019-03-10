//
//  String+Extension.swift
//  Tweeter
//
//  Created by MACOS on 3/6/19.
//  Copyright © 2019 MACOS. All rights reserved.
//

import Foundation

public extension String {
    subscript(safe index: Index) -> Character? {
        guard index >= startIndex && index < endIndex else {
            return nil
        }
        return self[index]
    }
    
    func moveIndex(of currentIndex: Index, by value: Int) -> Index {
        if value >= 0 {
            if distance(from: currentIndex, to: endIndex) <= value {
                return endIndex
            }
        } else {
            if distance(from: startIndex, to: currentIndex) <= abs(value) {
                return startIndex
            }
        }
        return index(currentIndex, offsetBy: value)
    }
    
    mutating func addPartIndicator(with partIndicator: String, at index: Index) {
        guard index >= startIndex && index < endIndex else {
            return
        }
        
        var indicator = partIndicator

        if self[safe: index] != " " {
            indicator += " "
        }
        insert(contentsOf: indicator, at: index)
    }
    
    func isStopWord(_ endPartIndex: Index) -> Bool {
        if endPartIndex == endIndex {
            return true
        }
        let previousIndex = moveIndex(of: endPartIndex, by: -1)
        if self[safe: previousIndex] == " " || self[safe: endPartIndex] == " " {
            return true
        }
        return false
    }
    
    func findStopWord(from index: Index, minIndex: Index) -> Index? {
        var currentIndex = index
        while currentIndex > minIndex {
            if self[safe: currentIndex] == " " {
                return currentIndex
            }
            currentIndex = moveIndex(of: currentIndex, by: -1)
        }
    
        return nil
    }
    
}
