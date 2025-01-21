//
//  NumberFormatManager.swift
//  PhotoSearchPractice
//
//  Created by BAE on 1/21/25.
//

import Foundation

class NumberFormatManager {
    
    static let shared = NumberFormatManager()
    private let formatter = NumberFormatter()
    private init() {}
    
    func threeDigitComma(number: Any) -> String {
        formatter.numberStyle = .decimal
        if let digitString = formatter.string(for: number) {
            return digitString
        } else {
            print(#function, "변환 실패")
            return "0"
        }
    }
    
}
