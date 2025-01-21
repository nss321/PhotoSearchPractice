//
//  TopicCollectionView.swift
//  PhotoSearchPractice
//
//  Created by BAE on 1/19/25.
//

import UIKit

class TopicCollectionView: BaseCollectionView {
    
    override func configCollectionView() {
        super.configCollectionView()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 4
        collectionViewLayout = layout
        contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        register(TopicCollectionViewCell.self, forCellWithReuseIdentifier: TopicCollectionViewCell.id)
        showsHorizontalScrollIndicator = false
    }
}

class TopicCollectionViewCell: BaseCollectionViewCell {
    static let id = "TopicCollectionViewCell"
    override func setupLayout() {
        super.setupLayout()
    }
    
    override func setupCell() {
        super.setupCell()
        imageView.do {
            $0.layer.cornerRadius = 12
        }
    }
    
    override func config(item: PhotoResult) {
        super.config(item: item)
    }
}
