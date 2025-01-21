//
//  TopicView.swift
//  PhotoSearchPractice
//
//  Created by BAE on 1/21/25.
//

import UIKit
import SnapKit

class TopicView: UIView {
    
    
    let verticalScrollView = UIScrollView()
    let scrollViewContainer = UIView()
    let topic1Header = UILabel()
    let topic2Header = UILabel()
    let topic3Header = UILabel()
    let topic1 = TopicCollectionView()
    let topic2 = TopicCollectionView()
    let topic3 = TopicCollectionView()
    var container1 = UIView()
    var container2 = UIView()
    var container3 = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configHeirarchy()
        configLayout()
        configView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configHeirarchy() {
        addSubview(verticalScrollView)
        verticalScrollView.addSubview(scrollViewContainer)
        [topic1Header, topic2Header,topic3Header, topic1, topic2, topic3].forEach {
            scrollViewContainer.addSubview($0)
        }
    }
    
    func configLayout() {
        verticalScrollView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
        
        scrollViewContainer.snp.makeConstraints {
            $0.edges.equalTo(verticalScrollView.contentLayoutGuide)
            $0.width.equalTo(verticalScrollView.frameLayoutGuide)
        }
        
        topic1Header.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(18)
        }
        topic1.snp.makeConstraints {
            $0.top.equalTo(topic1Header.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(imageHeight)
        }
        
        topic2Header.snp.makeConstraints {
            $0.top.equalTo(topic1.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(18)
        }
        topic2.snp.makeConstraints {
            $0.top.equalTo(topic2Header.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(imageHeight)
        }
        
        topic3Header.snp.makeConstraints {
            $0.top.equalTo(topic2.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(18)
        }
        topic3.snp.makeConstraints {
            $0.top.equalTo(topic3Header.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(imageHeight)
            $0.bottom.equalToSuperview().inset(18)
        }
    }
    
    func configView() {
        backgroundColor = .white
        verticalScrollView.showsVerticalScrollIndicator = false
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
    }
    
}
















