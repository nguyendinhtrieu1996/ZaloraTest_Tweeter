//
//  Message.swift
//  Tweeter
//
//  Created by MACOS on 3/6/19.
//  Copyright © 2019 MACOS. All rights reserved.
//

import UIKit

struct SplitPoint {
    var startIndex: String.Index
    var endIndex: String.Index
    var currentPart: Int
    
    init(_ startIndex: String.Index, _ endIndex: String.Index, _ currentPart: Int) {
        self.startIndex = startIndex
        self.endIndex = endIndex
        self.currentPart = currentPart
    }
    
    static func partIndicator(currentPart: Int, totalPart: Int) -> String {
        return "\(currentPart)/\(totalPart)"
    }
    
    func partIndicatorRange(in text: String, partIndicator: String) -> Range<String.Index> {
        let index = text.moveForward(currentIndex: startIndex, value: partIndicator.count)
        return startIndex..<index
    }
    
}

// MARK: -

public class Message {
    private (set) var text = ""
    private var cacheMessage: String?
    private (set) var currentPart: Int?
    private (set) var totalPart: Int?
    public static var maxLenght = 50
    
    init(text: String) {
        self.text = text
    }
    
    init(text: String, currentPart: Int, totalPart: Int? = nil) {
        self.text = text
        self.currentPart = currentPart
        self.totalPart = totalPart
    }
    
    func setTotalPart(with value: Int) {
        totalPart = value
    }
    
    static func splitMessage(_ string: String, totalPart: Int? = nil) -> [Message]? {
        var text = string
        let count = text.count
        guard count > maxLenght else {
            return [Message(text: text)]
        }
        var estimateParts = Int(ceil(CGFloat(count) / CGFloat(maxLenght)))
        if let totalPart = totalPart{
            estimateParts = totalPart
        }
        var startIndex = text.startIndex
        var endIndex = text.moveForward(currentIndex: startIndex, value: maxLenght)
        var splitPoints: [SplitPoint] = []
        var currentParts = 0
        var partIndicator = ""
        
        while startIndex != endIndex {
            currentParts += 1
            partIndicator = SplitPoint.partIndicator(currentPart: currentParts, totalPart: estimateParts)
            let isChangeEndIndex = text.addPartIndicator(with: partIndicator, at: startIndex, endIndex: endIndex)
            
            if isChangeEndIndex {
                let distance = text.distance(from: startIndex, to: endIndex) - maxLenght
                if distance > 0 {
                    endIndex = text.moveBackward(currentIndex: endIndex, value: distance)
                } else if distance < 0 {
                    endIndex = text.endIndex
                }
            }
            
            if !text.isStopWord(index: endIndex) {
                let minIndex = text.moveForward(currentIndex: startIndex, value: partIndicator.count + 1)
                guard let stopWordIndex = text.findStopWord(from: endIndex, minIndex: minIndex) else {
                    return nil
                }
                endIndex = stopWordIndex
            }
            
            let point = SplitPoint(startIndex, endIndex, currentParts)
            splitPoints.append(point)
            startIndex = endIndex
            endIndex = text.moveForward(currentIndex: endIndex, value: maxLenght)
        }
        
        if currentParts == estimateParts {
            return mapMessages(from: text, points: splitPoints, totalParts: currentParts)
        } else if currentParts.description.count == estimateParts.description.count {
            text = replacePartIndicator(string: text, points: splitPoints, totalPart: currentParts)
            return mapMessages(from: text, points: splitPoints, totalParts: currentParts)
        } else {
            return splitMessage(string, totalPart: currentParts)
        }
    }
    
    private static func mapMessages(from text: String, points: [SplitPoint], totalParts: Int)
        -> [Message] {
            var messages: [Message] = []
            for (index, point) in points.enumerated() {
                let splitText = String(text[point.startIndex..<point.endIndex])
                messages.append(Message(text: splitText, currentPart: index, totalPart: totalParts))
            }
            return messages
    }
    
    private static func replacePartIndicator(string: String, points: [SplitPoint], totalPart: Int) -> String {
        var output = string
        var partIndicator = ""
        for point in points {
            partIndicator = SplitPoint.partIndicator(currentPart: point.currentPart, totalPart: totalPart)
            let range = point.partIndicatorRange(in: string, partIndicator: partIndicator)
            output.replaceSubrange(range, with: partIndicator)
        }
        return output
    }
    
}

