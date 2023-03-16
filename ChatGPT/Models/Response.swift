//
//  Response.swift
//  ChatGPT
//
//  Created by Yurii on 16.03.2023.
//

import Foundation

struct Response: Codable {
    var id: String
    var choices: [Choices]
}

struct Choices: Codable {
    var text: String
}
