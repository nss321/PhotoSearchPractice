//
//  BaseViewController.swift
//  PhotoSearchPractice
//
//  Created by BAE on 1/18/25.
//

import UIKit

class BaseViewController: UIViewController {
    
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
        [searchBar, stackView, scrollView, collectionView].forEach { view.addSubview($0) }
    }
    
    func configLayout() {
        
    }
    
    func configView() {
        view.backgroundColor = .systemBackground
    }
}
