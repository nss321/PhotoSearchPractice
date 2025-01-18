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
    
//    override func viewDidLoad() {
//    
//    }
    
    override func configHierarchy() {
        [titleLabel, scrollView].forEach { view.addSubview($0) }
        scrollView.addSubview(stackView)
        [topic1, topic2, topic3].forEach { stackView.addArrangedSubview($0) }
    }

    override func configLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(baseMargin)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        stackView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.edges.equalToSuperview()
        }
    
    }
    
    override func configView() {
        super.configView()
        titleLabel.do {
            $0.text = "OUR TOPIC"
//            $0.font = .preferredFont(forTextStyle: .largeTitle) // largetitle -> 32
            $0.font = .systemFont(ofSize: 32, weight: .bold)
        }
        
        scrollView.showsVerticalScrollIndicator = false
        
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .equalSpacing
    }
}
