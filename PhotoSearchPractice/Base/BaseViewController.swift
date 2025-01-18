//
//  BaseViewController.swift
//  PhotoSearchPractice
//
//  Created by BAE on 1/18/25.
//

import UIKit

class BaseViewController: UIViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    let horizontalStackView = UIStackView()
    let verticalStackView = UIStackView()
    let horizontalScrollView = UIScrollView()
    let verticalScrollView = UIScrollView()
    let collectionView = BaseCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configHierarchy()
        configLayout()
        configView()
    }
    
    func configHierarchy() {
        print(#function)
        [horizontalStackView, verticalStackView, horizontalScrollView, verticalScrollView, collectionView].forEach { view.addSubview($0) }
    }
    
    func configLayout() {
        
    }
    
    func configView() {
        print(#function)
        view.backgroundColor = .systemBackground
        horizontalStackView.do {
            $0.axis = .horizontal
            $0.backgroundColor = .clear
            $0.distribution = .fillProportionally
        }
        horizontalScrollView.do {
            $0.showsHorizontalScrollIndicator = false
            $0.contentInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        }
        verticalStackView.do {
            $0.axis = .vertical
            $0.backgroundColor = .clear
        }
        
        
    }
}
