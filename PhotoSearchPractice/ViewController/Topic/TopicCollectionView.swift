//
//  TopicCollectionView.swift
//  PhotoSearchPractice
//
//  Created by BAE on 1/19/25.
//

import UIKit

class TopicCollectionView: BaseCollectionView {
    
//    let topic: Topic
    
//    init(topic: Topic) {
//        self.topic = topic
//    }
    
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

/*
 1. 컬렉션 뷰 셀을 이미지, 스택, 스크롤로 재구성
 2. 섹션 헤더를 각각 골든아워, 비즈니스, 건축으로
 3. 섹션, 아이템의 didselectitemat하면될듯
 
 
 */
