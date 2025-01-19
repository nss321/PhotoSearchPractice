//
//  TopicResponse.swift
//  PhotoSearchPractice
//
//  Created by BAE on 1/19/25.
//

import Foundation

//struct PhotoResult: Decodable {
//    let id: String
//    let created_at: String
//    let updated_at: String
//    let width: Int
//    let height: Int
//    let urls: PhotoResultUrl
//    let likes: Int
//    let liked_by_user: Bool
//}

//struct TopicResultUrl: Decodable {
//    let small: String
//    let thumb: String
//}

struct TopicResultUser: Decodable {
    let username: String
}
