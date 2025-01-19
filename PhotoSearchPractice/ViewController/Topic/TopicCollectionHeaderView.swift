//
//  TopicCollectionHeaderView.swift
//  PhotoSearchPractice
//
//  Created by BAE on 1/19/25.
//

import UIKit
import SnapKit
import Then

class TopicCollectionHeaderView: UICollectionReusableView {
    static let id = "TopicCollectionHeaderView"
    
    private let sectionLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubview(sectionLabel)
        sectionLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(2)
        }
        sectionLabel.font = .preferredFont(forTextStyle: .headline)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func config(section: String) {
        sectionLabel.text = section
        
    }
}
