//
//  TopicViewController.swift
//  PhotoSearchPractice
//
//  Created by BAE on 1/18/25.
//

import UIKit
import SnapKit
import Then

class TopicViewController: BaseViewController {
    
    let topic1 = EachTopicView(topic: .goldenHour)
    let topic2 = EachTopicView(topic: .business)
    let topic3 = EachTopicView(topic: .architecture)
    let topic4 = EachTopicView(topic: .architecture)
    let topic5 = EachTopicView(topic: .architecture)
    let topic6 = EachTopicView(topic: .architecture)
    
//    override func viewDidLoad() {
//    
//    }
    
    override func configHierarchy() {
        [verticalScrollView].forEach { view.addSubview($0) }
        verticalScrollView.addSubview(verticalStackView)
        [topic1, topic2, topic3, topic4, topic5, topic6].forEach { verticalStackView.addArrangedSubview($0) }
    }

    override func configLayout() {
//        titleLabel.snp.makeConstraints {
//            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
//            $0.horizontalEdges.equalToSuperview().inset(baseMargin)
//        }
        
        verticalScrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        verticalStackView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.edges.equalToSuperview()
        }
    
    }
    
    override func configView() {
        super.configView()
        
        self.navigationItem.title = "OUR TOPIC"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .automatic
        
        verticalScrollView.showsVerticalScrollIndicator = false
        
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 20
        verticalStackView.distribution = .equalSpacing
    }
}
