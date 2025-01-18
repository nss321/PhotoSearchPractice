//
//  Untitled.swift
//  PhotoSearchPractice
//
//  Created by BAE on 1/18/25.
//

import UIKit

enum ColorFilter: String {
    case black = "black"
    case white = "white"
    case yellow = "yellow"
    case red = "red"
    case purple = "purple"
    case green = "green"
    case blue = "blue"
    
    var code: String {
        rawValue
    }
}

class BaseButton: UIButton {
    
    let colorIndicator = UIView()
    var colorQuery = ""
    var config = UIButton.Configuration.plain()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtonStyle()
    }
    
    convenience init(color: ColorFilter, title: String) {
        self.init(frame: .zero)
        self.colorQuery = color.rawValue
        
        switch color {
            
        case .black:
            configButton(color: .unsplashBlack, title: title)
        case .white:
            configButton(color: .unsplashWhite, title: title)
        case .yellow:
            configButton(color: .unsplashYellow, title: title)
        case .red:
            configButton(color: .unsplashRed, title: title)
        case .purple:
            configButton(color: .unsplashPurple, title: title)
        case .green:
            configButton(color: .unsplashGreen, title: title)
        case .blue:
            configButton(color: .unsplashGreen, title: title)
        }
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupButtonStyle() {
        backgroundColor = .systemGray4
        clipsToBounds = true
        layer.cornerRadius = 16
        
    }
    
    func configButton(color: UIColor, title: String) {
//        let color = UIColor(hex: color.rawValue)
        let circleColor = UIImage(systemName: "circle.fill")?.withTintColor(color, renderingMode: .alwaysOriginal)
        config.image = circleColor
        config.title = title
        config.background.backgroundColor = .secondarySystemBackground
        config.baseForegroundColor = .black
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 2, bottom: 0, trailing: 12)
        self.configuration = config
        
        self.addAction(UIAction(handler: { _ in
//            print(self.colorCode)
        }), for: .touchUpInside)
    }
    
    
}
