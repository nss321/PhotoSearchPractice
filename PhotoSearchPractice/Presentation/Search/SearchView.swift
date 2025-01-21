//
//  SearchView.swift
//  PhotoSearchPractice
//
//  Created by BAE on 1/21/25.
//

import UIKit
import SnapKit

class SearchView: BaseView {
    
    let horizontalScrollView = UIScrollView()
    let horizontalStackView = UIStackView()
    let blackButton = BaseButton(color: .black, title: "블랙")
    let whiteButton = BaseButton(color: .white, title: "화이트")
    let yellowButton = BaseButton(color: .yellow, title: "옐로우")
    let redButton = BaseButton(color: .red, title: "레드")
    let purpleButton = BaseButton(color: .purple, title: "퍼플")
    let greenButton = BaseButton(color: .green, title: "그린")
    let blueButton = BaseButton(color: .blue, title: "블루")
    var collectionView = ResultCollectionView()
    let notiLabel = UILabel()
    let orderButton = UIButton()
    
    override func configHierarchy() {
        addSubview(notiLabel)
        horizontalScrollView.addSubview(horizontalStackView)
        
        [blackButton, whiteButton, yellowButton, redButton, purpleButton, greenButton, blueButton].forEach {
            horizontalStackView.addArrangedSubview($0)
        }
        addSubview(orderButton)
    }
    
    override func configLayout() {
        notiLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        horizontalScrollView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(4)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(32)
        }
        horizontalStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(horizontalScrollView.snp.bottom).offset(4)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
        
        orderButton.snp.makeConstraints {
            $0.centerY.equalTo(horizontalStackView.snp.centerY)
            $0.trailing.equalToSuperview().offset(8)
        }
    }
    
    override func configView() {
        
    }
}
