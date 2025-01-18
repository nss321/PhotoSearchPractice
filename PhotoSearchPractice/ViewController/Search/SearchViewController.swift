//
//  SearchViewController.swift
//  PhotoSearchPractice
//
//  Created by BAE on 1/18/25.
//

import UIKit
import SnapKit
import Then

class SearchViewController: BaseViewController {
    
    
    let blackButton = BaseButton(color: .black, title: "블랙")
    let whiteButton = BaseButton(color: .white, title: "화이트")
    let yellowButton = BaseButton(color: .yellow, title: "옐로우")
    let redButton = BaseButton(color: .red, title: "레드")
    let purpleButton = BaseButton(color: .purple, title: "퍼플")
    let greenButton = BaseButton(color: .green, title: "그린")
    let blueButton = BaseButton(color: .blue, title: "블루")
    
    override func configHierarchy() {
        [horizontalScrollView, verticalScrollView].forEach { view.addSubview($0) }
        horizontalScrollView.addSubview(horizontalStackView)
        verticalScrollView.addSubview(verticalStackView)
        
        [blackButton, whiteButton, yellowButton, redButton, purpleButton, greenButton, blueButton].forEach {
            horizontalStackView.addArrangedSubview($0)
        }
        
    }
    
    override func configLayout() {
        horizontalScrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(4)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(32)
        }
        horizontalStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalToSuperview()
        }
    }
    
    override func configView() {
        super.configView()
//        searchController.delegate = self
        searchController.searchBar.delegate = self
        self.navigationItem.title = "SEARCH PHOTO"
        self.navigationItem.searchController = searchController
        searchController.navigationItem.hidesSearchBarWhenScrolling = false
        horizontalStackView.spacing = 4
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        NetworkService.shared.searchPhotos(keyword: searchBar.text!)
    }
    
}
