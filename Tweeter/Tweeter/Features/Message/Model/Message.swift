//
//  Message.swift
//  Tweeter
//
//  Created by MACOS on 3/6/19.
//  Copyright © 2019 MACOS. All rights reserved.
//

import UIKit

public struct SplitPoint {
    private (set) var startIndex: String.Index
    private (set) var endIndex: String.Index
    private (set) var currentPart: Int
    
    init(_ startIndex: String.Index, _ endIndex: String.Index, _ currentPart: Int) {
        self.startIndex = startIndex
        self.endIndex = endIndex
        self.currentPart = currentPart
    }
    
    static func partIndicator(_ currentPart: Int, _ totalPart: Int) -> String {
        return "\(currentPart)/\(totalPart)"
    }
    
    func partIndicatorRange(in text: String, _ partIndicator: String) -> Range<String.Index> {
        let endIndex = text.moveIndex(of: startIndex, by: partIndicator.count)
        return startIndex..<endIndex
    }
    
}

// MARK: -

public class Message : Equatable{
    private (set) var text = ""
    public static var maxLenght = 50
    
    init(text: String) {
        self.text = text
    }
    
    public static func == (lhs: Message, rhs: Message) -> Bool {
        return lhs.text == rhs.text
    }

    static func splitMessage(_ string: String, totalPart: Int? = nil) -> [Message]? {
        guard string.count > maxLenght else {
            return [Message(text: string)]
        }
        var estimateParts = Int(ceil(CGFloat(string.count) / CGFloat(maxLenght)))
        if let totalPart = totalPart {
            estimateParts = totalPart
        }
        var text = string
        var startPartIndex = text.startIndex
        var endPartIndex = text.moveIndex(of: startPartIndex, by: maxLenght)
        var splitPoints: [SplitPoint] = []
        var currentParts = 0
        var partIndicator = ""
        
        while startPartIndex < endPartIndex {
            let isEndOfText = (endPartIndex == text.endIndex)
            currentParts += 1
            partIndicator = SplitPoint.partIndicator(currentParts, estimateParts)
            text.addPartIndicator(with: partIndicator, at: startPartIndex)
            
            if isEndOfText {
                let distance = maxLenght - text.distance(from: startPartIndex, to: endPartIndex)
                if distance > 0 {
                     endPartIndex = text.moveIndex(of: endPartIndex, by: distance)
                }
            }
          
            if !text.isStopWord(endPartIndex) {
                let minIndex = text.moveIndex(of: startPartIndex, by: partIndicator.count)
                guard let stopWordIndex = text.findStopWord(from: endPartIndex, minIndex: minIndex) else {
                    return nil
                }
                endPartIndex = stopWordIndex
            }
            
            let point = SplitPoint(startPartIndex, endPartIndex, currentParts)
            splitPoints.append(point)
            startPartIndex = endPartIndex
            endPartIndex = text.moveIndex(of: endPartIndex, by: maxLenght)
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
            var splitText = ""
            var messages: [Message] = []
            for point in points {
                splitText = String(text[point.startIndex..<point.endIndex])
                messages.append(Message(text: splitText))
            }
            return messages
    }
    
    private static func replacePartIndicator(string: String, points: [SplitPoint], totalPart: Int) -> String {
        var output = string
        var partIndicator = ""
        for point in points {
            partIndicator = SplitPoint.partIndicator(point.currentPart, totalPart)
            let range = point.partIndicatorRange(in: string, partIndicator)
            output.replaceSubrange(range, with: partIndicator)
        }
        return output
    }
    
}

