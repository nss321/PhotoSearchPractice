//
//  EachTopicView.swift
//  PhotoSearchPractice
//
//  Created by BAE on 1/19/25.
//

import UIKit
import SnapKit
import Then

class EachTopicView: UIView {
    
//    var topicPhotoList = [TopicResponse(id: "", updated_at: "", urls: TopicResultUrl(thumb: ""), likes: 0, liked_by_user: false)] {
//        didSet {
//            collectionView.reloadData()
//        }
//    }
    var topicPhotoList: [PhotoResult] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    let topicLabel = UILabel()
    let stackView = UIStackView()
    let scrollView = UIScrollView()
    let imageWidth = (UIScreen.main.bounds.width - 20) / 2
    let imageHeight = UIScreen.main.bounds.height / 3.5
    
    let image1 = UIImageView()
    let image2 = UIImageView()
    let image3 = UIImageView()
    
    let collectionView = TopicCollectionView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupView()
        print(#function)
    }
    
    convenience init(topic: Topic) {
        self.init(frame: .zero)
        self.configTopic(topic: topic)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupView() {
        backgroundColor = .clear
        
        topicLabel.do {
            $0.font = .preferredFont(forTextStyle: .headline)
        }
        
        collectionView.do {
            $0.delegate = self
            $0.dataSource = self
        }
        
//        scrollView.backgroundColor = .clear
//        scrollView.showsHorizontalScrollIndicator = false
//        stackView.backgroundColor = .clear
//        
//        stackView.do {
//            $0.axis = .horizontal
//            $0.spacing = 8
//            $0.distribution = .equalSpacing
//        }
//        
//        image1.do {
//            $0.backgroundColor = .red
//            $0.clipsToBounds = true
//            $0.layer.cornerRadius = 12
//        }
//        image2.do {
//            $0.backgroundColor = .systemYellow
//            $0.clipsToBounds = true
//            $0.layer.cornerRadius = 12
//        }
//        image3.do {
//            $0.backgroundColor = .systemTeal
//            $0.clipsToBounds = true
//            $0.layer.cornerRadius = 12
//        }
        
    }
    
    private func setupLayout() {
        addSubview(topicLabel)
        addSubview(collectionView)
        addSubview(scrollView)
        scrollView.addSubview(stackView)
        [image1, image2, image3].forEach { stackView.addArrangedSubview($0) }
        
        self.snp.makeConstraints {
            $0.height.equalTo(UIScreen.main.bounds.height / 3.5)
        }
        
        topicLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(18)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(topicLabel.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
//        scrollView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
//        scrollView.snp.makeConstraints {
//            $0.top.equalTo(topicLabel.snp.bottom).offset(12)
//            $0.horizontalEdges.equalToSuperview()
//            $0.bottom.equalToSuperview()
//        }
//        
//        stackView.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//            $0.height.equalTo(scrollView.snp.height)
//        }
//        
//        image1.snp.makeConstraints {
//            $0.width.equalTo(imageWidth)
//            $0.height.equalTo(scrollView.snp.height)
//        }
//        image2.snp.makeConstraints {
//            $0.width.equalTo(imageWidth)
//            $0.height.equalTo(scrollView.snp.height)
//        }
//        image3.snp.makeConstraints {
//            $0.width.equalTo(imageWidth)
//            $0.height.equalTo(scrollView.snp.height)
//        }
        
        
    }
    
    
    // TODO: API 호출 붙이기. 잘 안되면, convenience init 빼고, configTopic을 TopicViewController의 configView에서 호출해서 넘겨줘야함.
    func configTopic(topic: Topic) {
        
        switch topic {
        case .goldenHour:
            topicLabel.text = "골든 아워"
            NetworkService.shared.topicPhotos(topic: .goldenHour) {
                self.topicPhotoList = $0
            }
            break
        case .business:
            topicLabel.text = "비즈니스 및 업무"
            NetworkService.shared.topicPhotos(topic: .business) {
                self.topicPhotoList = $0
            }
            break
        case .architecture:
            topicLabel.text = "건축 및 인테리어"
            NetworkService.shared.topicPhotos(topic: .architecture) {
                self.topicPhotoList = $0
            }
            break
        }
        
    }
    
}

extension EachTopicView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        topicPhotoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = topicPhotoList[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopicCollectionViewCell.id, for: indexPath) as! TopicCollectionViewCell
        
        cell.config(item: item)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: imageWidth, height: imageHeight-topicLabel.frame.height-12)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        dump(topicPhotoList[indexPath.item])
        let vc = PhotoDetailViewController()
        vc.givenPhotoInfo = topicPhotoList[indexPath.item]
        
    }
}
