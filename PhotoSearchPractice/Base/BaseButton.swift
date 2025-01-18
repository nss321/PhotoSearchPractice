//
//  Untitled.swift
//  PhotoSearchPractice
//
//  Created by BAE on 1/18/25.
//

import UIKit

class BaseButton: UIButton {
    
    let colorIndicator = UIView()
    var config = UIButton.Configuration.plain()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtonStyle()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupButtonStyle() {
        backgroundColor = .systemGray4
        clipsToBounds = true
        layer.cornerRadius = frame.height / 2
        
//        colorIndicator.clipsToBounds = true
    }
    
    func configButton(color: UIColor, title: String) {
        let colorCircle = UIImage(systemName: "circle.fill")?.withTintColor(color, renderingMode: .alwaysOriginal)
        config.image = colorCircle
        
        //        var symbolImageConfig = UIImage.SymbolConfiguration
        //        colorIndicator.backgroundColor = colo
        config.title = title
        config.baseForegroundColor = .black
        
        
        self.configuration = config
    }
    
}
