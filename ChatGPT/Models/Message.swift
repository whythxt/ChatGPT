//
//  Message.swift
//  ChatGPT
//
//  Created by Yurii on 16.03.2023.
//

import Foundation

enum Sender {
    case user
    case gpt
}

struct Message {
    var id: String
    var content: String
    var date: Date
    var sender: Sender

    static let example = [
        Message(id: UUID().uuidString, content: "Test me", date: Date(), sender: .gpt),
        Message(id: UUID().uuidString, content: "As long as you beg me", date: Date(), sender: .user),
    ]
}
