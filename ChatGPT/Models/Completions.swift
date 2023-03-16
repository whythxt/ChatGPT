//
//  Completions.swift
//  ChatGPT
//
//  Created by Yurii on 16.03.2023.
//

import Foundation

struct Completions: Codable {
    var model: String
    var prompt: String
    var temperature: Float?
    var max_tokens: Float
}
