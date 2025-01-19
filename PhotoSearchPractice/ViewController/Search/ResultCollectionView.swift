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

class ResultCollectionViewCell: BaseCollectionViewCell {
    
    static let id = "ResultCollectionViewCell"
    
    override func setupLayout() {
        super.setupLayout()
    }
    
    override func setupCell() {
        super.setupCell()
    }
    
    override func config(item: PhotoResult) {
        super.config(item: item)
    }
}
