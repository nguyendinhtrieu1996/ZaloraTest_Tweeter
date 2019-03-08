//
//  String+Extension.swift
//  Tweeter
//
//  Created by MACOS on 3/6/19.
//  Copyright © 2019 MACOS. All rights reserved.
//

import Foundation

public extension String {
    subscript (_ i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    
    subscript(_ range: CountableRange<Int>) -> String {
        let idx1 = index(startIndex, offsetBy: max(0, range.lowerBound))
        let idx2 = index(startIndex, offsetBy: min(self.count, range.upperBound))
        return String(self[idx1..<idx2])
    }
    
    func distance(to index: Index) -> Int {
        return distance(from: startIndex, to: index)
    }
    
    func splitMessage() -> [String]? {
        let count = self.count
        let maxLenght = 50
        
        guard count > maxLenght else {
            return [self]
        }
        
        var output: [String] = []
        var currentIndex = 0
        var numberOfParts = 0
        
        while currentIndex < count {
            let previousIndex = currentIndex
            numberOfParts += 1
            currentIndex += maxLenght
            
            var subString = self[previousIndex..<currentIndex]
            
            if subString.last == " " || currentIndex >= count {
                output.append(subString)
            } else if self[index(startIndex, offsetBy: currentIndex)] == " " {
                output.append(subString)
            } else {
                guard let lastIndex = subString.lastIndex(of: " ") else {
                    return nil
                }
                
                let distance = subString.distance(from: startIndex, to: lastIndex)
                currentIndex = previousIndex + distance
                subString = self[previousIndex..<currentIndex]
                output.append(subString)
            }
        }
        
        return output
    }
}
