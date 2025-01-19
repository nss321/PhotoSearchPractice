//
//  TopicResponse.swift
//  PhotoSearchPractice
//
//  Created by BAE on 1/19/25.
//

import Foundation

struct TopicResponse: Decodable {
    let id: String
    let updated_at: String
    let urls: TopicResultUrl
    let likes: Int
    let liked_by_user: Bool
}

struct TopicResultUrl: Decodable {
    let thumb: String
}

