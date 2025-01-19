//
//  PhotoDetail.swift
//  PhotoSearchPractice
//
//  Created by BAE on 1/19/25.
//

struct PhotoDetail: Decodable {
    let id: String
    let downloads: PhotoDetailDownloads
    let views: PhotoDetailViews
}

struct PhotoDetailDownloads: Decodable {
    let total: Int
    let historical: PhotoHistory
}

struct PhotoDetailViews: Decodable {
    let total: Int
    let historical: PhotoHistory
}

struct PhotoHistory: Decodable {
    let change: Int
    let resolution: String
    let quantity: Int
    let values: [PhotoDetailValue]
}

struct PhotoDetailValue: Decodable {
    let date: String
    let value: Int
}
