//
//  SplitMessageTestCase.swift
//  TweeterTests
//
//  Created by Nguyen Dinh Trieu on 3/11/19.
//  Copyright © 2019 MACOS. All rights reserved.
//

@testable import Tweeter

struct SplitMessageTestCase {
    let inputText: String
    let outputMessages: [Message]
}

// MARK: -

let text10Characters = SplitMessageTestCase(inputText: "0123456789", outputMessages: [Message(text: "0123456789")])
let text50Character = SplitMessageTestCase(
    inputText: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
    outputMessages: [Message(text: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")]
)

let textSplitTwoParts = SplitMessageTestCase(
    inputText: "I can't believe Tweeter now supports chunking my messages, so I don't have to do it myself.",
    outputMessages: [Message(text: "1/2 I can't believe Tweeter now supports chunking"),
                     Message(text: "2/2 my messages, so I don't have to do it myself.")]
)
