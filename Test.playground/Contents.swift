import UIKit

struct SplitPoint {
    var startIndex: String.Index
    var endIndex: String.Index
    var currentPart: Int
    var totalPart: Int
}

extension String {
    func moveForward(currentIndex: Index, value: Int = 1) -> Index {
        return index(currentIndex, offsetBy: min(self.count, value))
    }
    
    mutating func splitMessage() -> [String]? {
        let count = self.count
        let maxLenght = 50
        
        guard count > maxLenght else {
            return [self]
        }
        
        var estimateNumberOfParts = Int(ceil(CGFloat(count) / CGFloat(maxLenght)))
        var startIndexSub = startIndex
        var endIndexSub = startIndexSub
        var arrayPoints: [SplitPoint] = []
        var currentPart = 0
        
        while startIndexSub < endIndex {
            currentPart += 1
            startIndexSub = endIndexSub
            endIndexSub = moveForward(currentIndex: endIndexSub, value: maxLenght)
            
            if endIndexSub >= endIndex
                || self[moveForward(currentIndex: endIndexSub)] == " "
                || self[endIndexSub] == " " {
                arrayPoints.append(SplitPoint(startIndex: startIndexSub,
                                              endIndex: endIndexSub,
                                              currentPart: currentPart,
                                              totalPart: 0))
                
                continue
            }
            
            if !moveBackToWord(startIndex: startIndexSub, endIndex: endIndexSub) {
                return nil
            }
        }
        
        return []
    }
    
    func moveBackToWord(startIndex: Index, endIndex: Index) -> Bool {
        while endIndex <= startIndex {
            
            
            if self[endIndex] == " " {
                
            }
        }
        return true
    }
    
}
