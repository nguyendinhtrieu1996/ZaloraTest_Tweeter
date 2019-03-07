import UIKit

extension String {
    subscript(_ range: CountableRange<Int>) -> String {
        let idx1 = index(startIndex, offsetBy: max(0, range.lowerBound))
        let idx2 = index(startIndex, offsetBy: min(self.count, range.upperBound))
        return String(self[idx1..<idx2])
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
            currentIndex += numberOfParts * maxLenght
            
            var subString = self[previousIndex..<currentIndex]
            
            if subString.last == " " {
                output.append(subString)
            } else {
                guard let lastIndex = subString.lastIndex(of: " ") else {
                    return nil
                }
                
                let distance = subString.distance(from: startIndex, to: lastIndex)
                currentIndex = distance
                subString = self[previousIndex..<currentIndex]
                output.append(subString)
            }
        }
        
        return output
    }
}


var str = "Hello, playground"
let output1 = str.splitMessage()

output1?.forEach { print("\n ++ \($0.description)") }

let str2 = "I can't believe Tweeter now supports chunking my messages, so I don't have to do it myself."
let output2 = str2.splitMessage()

output2?.forEach { print("\n ++ \($0.description)") }
