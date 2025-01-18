//
//  BaseViewController.swift
//  PhotoSearchPractice
//
//  Created by BAE on 1/18/25.
//

import UIKit

class BaseViewController: UIViewController {
    
    let titleLabel = UILabel()
    let searchBar = UISearchBar()
    let stackView = UIStackView()
    let scrollView = UIScrollView()
    let collectionView = BaseCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configHierarchy()
        configLayout()
        configView()
    }
    
    func configHierarchy() {
        print(#function)
        [titleLabel, searchBar, stackView, scrollView, collectionView].forEach { view.addSubview($0) }
    }
    
    func configLayout() {
        
    }
    
    func configView() {
        print(#function)
        view.backgroundColor = .systemBackground
    }
}
