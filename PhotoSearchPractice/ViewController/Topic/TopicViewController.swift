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
    
    var goldenHourPhotoList: [PhotoResult] = [] {
        didSet {
            topic1.reloadData()
            print("golden hour reloaded")
        }
    }
    var businessPhotoList: [PhotoResult] = [] {
        didSet {
            topic2.reloadData()
            print("buisness hour reloaded")
        }
    }
    var architecturePhotoList: [PhotoResult] = [] {
        didSet {
            topic3.reloadData()
            print("architecture hour reloaded")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTopicPhotos()
    }
    
    override func configHierarchy() {
        view.addSubview(verticalScrollView)
        [topic1Header,topic2Header,topic3Header, topic1, topic2, topic3].forEach { verticalScrollView.addSubview($0) }
    }
    
    override func configLayout() {
        verticalScrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        /*
         코드로 작성할 땐 꼭 contentlayoutguide와 framelayoutguide에 주의하자,,,
         */
        
        topic1Header.snp.makeConstraints {
            $0.top.equalTo(verticalScrollView.contentLayoutGuide.snp.top)
            $0.leading.equalTo(verticalScrollView.contentLayoutGuide).inset(18)
        }
        topic1.snp.makeConstraints {
            $0.top.equalTo(topic1Header.snp.bottom).offset(12)
            $0.horizontalEdges.equalTo(verticalScrollView.contentLayoutGuide)
            $0.width.equalTo(verticalScrollView.frameLayoutGuide)
            $0.height.equalTo(imageHeight)
        }
        topic2Header.snp.makeConstraints {
            $0.top.equalTo(topic1.snp.bottom).offset(16)
            $0.horizontalEdges.equalTo(verticalScrollView.contentLayoutGuide).inset(18)
        }
        topic2.snp.makeConstraints {
            $0.top.equalTo(topic2Header.snp.bottom).offset(12)
            $0.horizontalEdges.equalTo(verticalScrollView.contentLayoutGuide)
            $0.width.equalTo(verticalScrollView.frameLayoutGuide)
            $0.height.equalTo(imageHeight)
        }
        topic3Header.snp.makeConstraints {
            $0.top.equalTo(topic2.snp.bottom).offset(16)
            $0.horizontalEdges.equalTo(verticalScrollView.contentLayoutGuide).inset(18)
        }
        topic3.snp.makeConstraints {
            $0.top.equalTo(topic3Header.snp.bottom).offset(12)
            $0.horizontalEdges.equalTo(verticalScrollView.contentLayoutGuide)
            $0.bottom.equalTo(verticalScrollView.contentLayoutGuide.snp.bottom)
            $0.width.equalTo(verticalScrollView.frameLayoutGuide)
            $0.height.equalTo(imageHeight)
        }
    }
    
    override func configView() {
        super.configView()
        
        self.navigationItem.title = "OUR TOPIC"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .automatic
    
        [topic1, topic2, topic3].forEach {
            $0.delegate = self
            $0.dataSource = self
        }
        
    }
    
    func fetchTopicPhotos() {
        NetworkService.shared.topicPhotos(topic: .goldenHour) {
            self.goldenHourPhotoList = $0
        }
        print("goldend hour requested")
        NetworkService.shared.topicPhotos(topic: .business) {
            self.businessPhotoList = $0
        }
        print("buisness hour requested")

        NetworkService.shared.topicPhotos(topic: .architecture) {
            self.architecturePhotoList = $0
        }
        print("architecture hour requested")

    }
}

extension TopicViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case topic1:
            return goldenHourPhotoList.count
        case topic2:
            return businessPhotoList.count
        case topic3:
            return architecturePhotoList.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopicCollectionViewCell.id, for: indexPath) as! TopicCollectionViewCell
        
        switch collectionView {
        case topic1:
            cell.config(item: goldenHourPhotoList[indexPath.item])
            break
        case topic2:
            cell.config(item: businessPhotoList[indexPath.item])
            break
        case topic3:
            cell.config(item: architecturePhotoList[indexPath.item])
            break
        default:
            break
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: imageWidth, height: imageHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PhotoDetailViewController()
        
        switch collectionView {
        case topic1:
            NetworkService.shared.photoDetail(id: goldenHourPhotoList[indexPath.item].id) {
                vc.photoDetail = $0
            }
            vc.givenPhotoInfo = goldenHourPhotoList[indexPath.item]
            break
        case topic2:
            NetworkService.shared.photoDetail(id: businessPhotoList[indexPath.item].id) {
                vc.photoDetail = $0
            }
            vc.givenPhotoInfo = businessPhotoList[indexPath.item]
            break
        case topic3:
            NetworkService.shared.photoDetail(id: architecturePhotoList[indexPath.item].id) {
                vc.photoDetail = $0
            }
            vc.givenPhotoInfo = architecturePhotoList[indexPath.item]
            break
        default:
            break
        }
        self.navigationController?.pushViewController(vc, animated: true)

    }
}
