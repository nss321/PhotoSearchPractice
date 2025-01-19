//
//  BaseViewController.swift
//  PhotoSearchPractice
//
//  Created by BAE on 1/18/25.
//

import UIKit

class BaseViewController: UIViewController {
    
    let topic1Header = UILabel()
    let topic2Header = UILabel()
    let topic3Header = UILabel()

    let topic1 = TopicCollectionView()
    let topic2 = TopicCollectionView()
    let topic3 = TopicCollectionView()
    
    let searchController = UISearchController()
    let horizontalStackView = UIStackView()
    let verticalStackView = UIStackView()
    let horizontalScrollView = UIScrollView()
    let verticalScrollView = UIScrollView()
    var collectionView = ResultCollectionView()
    
    let blackButton = BaseButton(color: .black, title: "블랙")
    let whiteButton = BaseButton(color: .white, title: "화이트")
    let yellowButton = BaseButton(color: .yellow, title: "옐로우")
    let redButton = BaseButton(color: .red, title: "레드")
    let purpleButton = BaseButton(color: .purple, title: "퍼플")
    let greenButton = BaseButton(color: .green, title: "그린")
    let blueButton = BaseButton(color: .blue, title: "블루")
    
    let imageWidth = (UIScreen.main.bounds.width - 20) / 2
    let imageHeight = UIScreen.main.bounds.height / 3.5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configHierarchy()
        configLayout()
        configView()
    }
    
    func configHierarchy() {
        [horizontalStackView, verticalStackView, horizontalScrollView, verticalScrollView, collectionView].forEach { view.addSubview($0) }
    }
    
    func configLayout() {
        
    }
    
    func configView() {
        view.backgroundColor = .systemBackground
        
        topic1Header.do {
            $0.text = "골든 아워"
            $0.font = .preferredFont(forTextStyle: .headline)
        }
        topic2Header.do {
            $0.text = "비즈니스 및 업무"
            $0.font = .preferredFont(forTextStyle: .headline)
        }
        topic3Header.do {
            $0.text = "건축 및 인테리어"
            $0.font = .preferredFont(forTextStyle: .headline)
        }
        
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
        searchController.searchBar.placeholder = "키워드 검색"
        
    }
}
