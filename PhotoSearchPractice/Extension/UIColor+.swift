//
//  UIColor+.swift
//  PhotoSearchPractice
//
//  Created by BAE on 1/19/25.
//

import UIKit

extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex) // 문자 파서 역할
        _ = scanner.scanString("#")  // scanString은 iOS13 부터 지원
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        self.init(red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgb & 0x0000FF) / 255.0,
                  alpha: 1)
        
        
    }
    
    static let unsplashBlack = UIColor(hex: "#000000")
    static let unsplashWhite = UIColor(hex: "#FFFFFF")
    static let unsplashYellow = UIColor(hex: "#FFEF62")
    static let unsplashRed = UIColor(hex: "#F04452")
    static let unsplashPurple = UIColor(hex: "#F9636E1")
    static let unsplashGreen = UIColor(hex: "#02B946")
    static let unsplashBlue = UIColor(hex: "#3C59FF")
}
