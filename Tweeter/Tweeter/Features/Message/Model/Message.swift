//
//  Message.swift
//  Tweeter
//
//  Created by MACOS on 3/6/19.
//  Copyright © 2019 MACOS. All rights reserved.
//

import Foundation

public class Message {
    private var text = ""
    private var cacheMessage: String?
    private (set) var currentPart: Int?
    private (set) var totalPart: Int?
    public static var maxLenghtSplitMessage = 50
    
    var message: String {
        if let message = cacheMessage {
            return message
        } else {
            if currentPart == nil {
                return text
            } else {
                let message = "\(currentPart ?? 0)/\(totalPart ?? 0) \(text)"
                return message
            }
        }
    }
    
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
    
    static func splitMessage(_ text: String) -> [Message]? {
        let count = text.count
        guard count > maxLenghtSplitMessage else {
            return [Message(text: text)]
        }
        
        var messages: [Message] = []
        var currentIndex = 0
        var numberOfParts = 0
        
        while currentIndex < count {
            let previousIndex = currentIndex
            numberOfParts += 1
            currentIndex += maxLenghtSplitMessage
            
            var subString = text[previousIndex..<currentIndex]
            
            if subString.last == " " || currentIndex >= count || text[currentIndex] == " " {
                messages.append(Message(text: subString, currentPart: numberOfParts))
            } else {
                guard let lastIndex = subString.lastIndex(of: " ") else {
                    return nil
                }
                let distance = subString.distance(to: lastIndex)
                currentIndex = previousIndex + distance
                subString = text[previousIndex..<currentIndex]
                messages.append(Message(text: subString, currentPart: numberOfParts))
                
            }
        }
        
        for index in 0..<messages.count {
            messages[index].setTotalPart(with: numberOfParts)
        }
        
        return messages
    }
    
}
