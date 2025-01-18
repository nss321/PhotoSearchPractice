//
//  resultCollectionView.swift
//  PhotoSearchPractice
//
//  Created by BAE on 1/19/25.
//

import UIKit
import Kingfisher


class ResultCollectionView: BaseCollectionView {
    
    
}

class ResultCollectionViewCell: UICollectionViewCell {
    
    let imageView = UIImage()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func config(item: String) {
//        let url = UR
    }
}
