//
//  SearchView.swift
//  PhotoSearchPractice
//
//  Created by BAE on 1/21/25.
//

import UIKit
import SnapKit
import Then

final class SearchView: BaseView {
    
    let searchController = UISearchController()
    let horizontalScrollView = UIScrollView()
    let horizontalStackView = UIStackView()
    // 굳이 지정된 색으로 해야하는가?
    // 좀 더 범용적으로 사용할 수 있도록 하고 싶음.
    // 컬러와 타이틀이 별개의 패러미터니까, 컬러에는 그냥 헥스 값을 넣어줘도? 되?지? 않을지?
    // 근데 이렇게 하면 enum이 필요 없을거 같다.,
    // 우선 정렬 버튼부터 손봐야겠다.
    // TODO: 더 범용성 있게 사용가능한 방향 고민하기.
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
        [horizontalScrollView, notiLabel, orderButton, collectionView].forEach { addSubview($0) }
        horizontalScrollView.addSubview(horizontalStackView)
        [blackButton, whiteButton, yellowButton, redButton, purpleButton, greenButton, blueButton].forEach {
            horizontalStackView.addArrangedSubview($0)
        }
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
        backgroundColor = .systemBackground
        searchController.searchBar.placeholder = "키워드 검색"
        searchController.navigationItem.hidesSearchBarWhenScrolling = true
        
        horizontalStackView.do {
            $0.spacing = 4
            $0.axis = .horizontal
            $0.backgroundColor = .clear
            $0.distribution = .fillProportionally
            //
//            $0.isLayoutMarginsRelativeArrangement = false
//            $0.layoutMargins = UIEdgeInsets(top: 0, left: 100, bottom: 0, right: 100)
//            $0.setCustomSpacing(100, after: blueButton)
        }
        horizontalScrollView.do {
            $0.showsHorizontalScrollIndicator = false
            $0.contentInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right:  80)
        }
        notiLabel.do {
            $0.text = "사진을 검색해보세요."
            $0.font = .systemFont(ofSize: 16, weight: .bold)
        }
        
        orderButton.do {
            var config = UIButton.Configuration.plain()
            config.title = "최신순"
            config.baseForegroundColor = .black
            config.background.backgroundColor = .white
            let image = UIImage(systemName: "line.3.horizontal.decrease.circle")?.withTintColor(.black, renderingMode: .alwaysOriginal)
            config.image = image
            config.background.strokeWidth = 1
            config.background.strokeColor = .gray
            
            $0.configuration = config
        }
    }
}
