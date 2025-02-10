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
    var results: [PhotoResult]
}

struct PhotoResult: Decodable {
    let id: String
    let created_at: String
    let updated_at: String
    let width: Int
    let height: Int
    let urls: PhotoResultUrl
    let likes: Int
    let liked_by_user: Bool
    let user: PhotoResultUser
    
    static func emptyPhoto() -> PhotoResult {
        return PhotoResult.init(id: "", created_at: "", updated_at: "", width: 0, height: 0, urls: PhotoResultUrl(small: "", thumb: ""), likes: 0, liked_by_user: false, user: PhotoResultUser(username: "", profile_image: PhotoResultProfileImage(small: "")))
    }
}

struct PhotoResultUrl: Decodable {
    let small: String
    let thumb: String
}

struct PhotoResultUser: Decodable {
    let username: String
    let profile_image: PhotoResultProfileImage
}

struct PhotoResultProfileImage: Decodable {
    let small: String
}

struct UnplashErrorMessage: Decodable {
    let errors: [String]
}
