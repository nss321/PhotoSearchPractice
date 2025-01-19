//
//  resultCollectionView.swift
//  PhotoSearchPractice
//
//  Created by BAE on 1/19/25.
//

import UIKit
import Kingfisher
import SnapKit
import Then


class ResultCollectionView: BaseCollectionView {
    
    override func configCollectionView() {
        self.register(ResultCollectionViewCell.self, forCellWithReuseIdentifier: ResultCollectionViewCell.id)
    }
}

class ResultCollectionViewCell: UICollectionViewCell {
    
    static let id = "ResultCollectionViewCell"
    
    let imageView = UIImageView()
    let likedContainer = UIView()
    let starSymbol = UIImageView()
    let likedCount = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupLayout() {
        [imageView, likedContainer].forEach { contentView.addSubview($0) }
        [starSymbol, likedCount].forEach { likedContainer.addSubview($0) }
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        likedContainer.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview().inset(8)
            $0.trailing.lessThanOrEqualToSuperview()
            $0.height.equalTo(28)
        }
        
        starSymbol.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview().dividedBy(2)
        }
        
        likedCount.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(starSymbol.snp.trailing).offset(12)
            $0.trailing.equalToSuperview().inset(12)
        }
        
    }
    
    private func setupCell() {
        imageView.do {
            $0.contentMode = .scaleAspectFill
            $0.clipsToBounds = true
        }
        
        likedContainer.do {
            print(#function)
            $0.clipsToBounds = true
            $0.backgroundColor = .darkGray
            $0.layer.cornerRadius = 14
//            $0.layer.borderColor = UIColor.red.cgColor
//            $0.layer.borderWidth = 1
        }
        
        starSymbol.do {
            let config = UIImage.SymbolConfiguration.init(font: .preferredFont(forTextStyle: .caption1), scale: .small)
            $0.image = UIImage(systemName: "star.fill")?
                .withTintColor(.systemYellow, renderingMode: .alwaysOriginal)
                .applyingSymbolConfiguration(config)
        }
        
        likedCount.do {
            $0.font = .preferredFont(forTextStyle: .caption1)
            $0.textColor = .white
        }
        
    }
    
    func config(item: PhotoResult) {
        print(#function)
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        likedCount.text = formatter.string(for: item.likes)
        imageView.kf.setImage(with: URL(string: item.urls.thumb))
    }
}
