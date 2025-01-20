//
//  DataFormatter.swift
//  PhotoSearchPractice
//
//  Created by BAE on 1/20/25.
//

import UIKit
import Then

class DateManager {
    static let shared = DateManager()
    
    // 2025-01-15T01:16:15Z
    // 2024-07-22T14:03:52Z
    // ISO 8601 format이라고 함.
    // yyyy-MM-ddThh:mm:ss-
    // 2024년 7월 3일 게시됨
    private init() { }
    
    private let convertToDate = DateFormatter().then {
        $0.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
    }
    
    private let convertToString = DateFormatter().then {
        $0.dateFormat = "yyyy년 M월 d일 게시됨"
    }
    
    func convertDateToString(date: String) -> String {
        guard let responseDate = convertToDate.date(from: date) else {
            print(#function, "날짜 변환 실패")
            return "0000년 0월 0일 게시됨"
        }
        return convertToString.string(from: responseDate)
    }
}
