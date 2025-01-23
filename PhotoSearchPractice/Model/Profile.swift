//
//  Profile.swift
//  PhotoSearchPractice
//
//  Created by BAE on 1/23/25.
//

import Foundation

struct Nickname: Codable {
    var text: String
}

struct Birthday: Codable {
    var date: Date
    var text: String
}

struct Level: Codable {
    var index: Int
    var text: String
}
