//
//  BaseViewController.swift
//  PhotoSearchPractice
//
//  Created by BAE on 1/18/25.
//

import UIKit
import SnapKit
import Then

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configHierarchy()
        configLayout()
        configView()
        configDelegate()
    }
    
    func configHierarchy() {
        
    }
    
    func configLayout() {
        
    }
    
    func configView() {
        view.backgroundColor = .systemBackground
    }
    
    func configDelegate() {
        
    }
    
    func topicSection(titleView: UILabel, collectionView: UICollectionView) -> UIView {
        let container = UIView()
        container.backgroundColor = .clear
        [titleView, collectionView].forEach { container.addSubview($0) }
        titleView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(18)
        }
        collectionView.snp.makeConstraints {
            $0.top.equalTo(titleView.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(imageHeight)
            $0.bottom.equalToSuperview()
        }
        
        return container
    }
}
