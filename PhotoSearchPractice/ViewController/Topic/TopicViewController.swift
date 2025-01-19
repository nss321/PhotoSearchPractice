//
//  TopicViewController.swift
//  PhotoSearchPractice
//
//  Created by BAE on 1/18/25.
//

import UIKit
import SnapKit
import Then

enum Topic: String {
    case goldenHour = "golden-hour"
    case business = "business-work"
    case architecture = "architecture-interior"
    
    var topicID: String {
        rawValue
    }
}

class TopicViewController: BaseViewController {    
    
    let topic1 = EachTopicView(topic: .goldenHour)
    let topic2 = EachTopicView(topic: .business)
    let topic3 = EachTopicView(topic: .architecture)
    
//    override func viewDidLoad() {
//    
//    }
    
    override func configHierarchy() {
        [verticalScrollView].forEach { view.addSubview($0) }
        verticalScrollView.addSubview(verticalStackView)
        [topic1, topic2, topic3].forEach { verticalStackView.addArrangedSubview($0) }
    }

    override func configLayout() {

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
