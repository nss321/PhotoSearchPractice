//
//  Photo.swift
//  PhotoSearchPractice
//
//  Created by BAE on 1/19/25.
//

import Foundation

struct Photo: Decodable {
    let total: Int
    let total_pages: Int
    let results: [PhotoResult]
}

struct PhotoResult: Decodable {
    let id: String
    let updated_at: String
    let urls: PhotoResultUrl
    let likes: Int
    let liked_by_user: Bool
}

struct PhotoResultUrl: Decodable {
    let thumb: String
}

struct PhotoSearchError: Decodable {
    let errors: [String]
}
