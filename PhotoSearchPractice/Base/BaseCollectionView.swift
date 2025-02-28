//
//  BaseCollectionView.swift
//  PhotoSearchPractice
//
//  Created by BAE on 1/18/25.
//

import UIKit

class BaseCollectionView: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        setupCollectionViewStyle()
        configCollectionView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupCollectionViewStyle() {
        backgroundColor = .clear
        
    }

    func configCollectionView() {
    }
    
}
