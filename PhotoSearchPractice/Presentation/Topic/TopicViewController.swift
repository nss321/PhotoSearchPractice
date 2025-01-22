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

final class TopicViewController: BaseViewController {
    
    private var goldenHourPhotoList = [PhotoResult]()
    private var businessPhotoList = [PhotoResult]()
    private var architecturePhotoList = [PhotoResult]()
    private let topicView = TopicView()
    
    override func loadView() {
        print(#function)
        view = topicView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTopicPhotos()
    }
    
    override func configView() {
        super.configView()
        
        self.navigationItem.title = "OUR TOPIC"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .automatic
        
    }
    
    override func configDelegate() {
        topicView.topic1.do {
            $0.delegate = self
            $0.dataSource = self
        }
        topicView.topic2.do {
            $0.delegate = self
            $0.dataSource = self
        }
        topicView.topic3.do {
            $0.delegate = self
            $0.dataSource = self
        }
    }
    
    private func fetchTopicPhotos() {
        let group = DispatchGroup()
        
        group.enter()
        NetworkService.shared.callPhotoRequest(api: .topic(topic: .goldenHour), type: [PhotoResult].self, completion: { PhotoList in
            self.goldenHourPhotoList = PhotoList
            group.leave()
        }, failureHandler: {
            self.showAlert(title: "로드 실패", message: $0.errors.debugDescription, handler: nil)
        })
        group.enter()
        NetworkService.shared.callPhotoRequest(api: .topic(topic: .business), type: [PhotoResult].self, completion: { PhotoList in
            self.businessPhotoList = PhotoList
            group.leave()
        }, failureHandler: {
            self.showAlert(title: "로드 실패", message: $0.errors.debugDescription, handler: nil)
        })

        group.enter()
        NetworkService.shared.callPhotoRequest(api: .topic(topic: .architecture), type: [PhotoResult].self, completion: { PhotoList in
            self.architecturePhotoList = PhotoList
            group.leave()
        }, failureHandler: {
            self.showAlert(title: "로드 실패", message: $0.errors.debugDescription, handler: nil)
        })
        
        group.notify(queue: .main) {
            self.topicView.topic1.reloadData()
            self.topicView.topic2.reloadData()
            self.topicView.topic3.reloadData()
        }
    }
}

extension TopicViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case topicView.topic1:
            return goldenHourPhotoList.count
        case topicView.topic2:
            return businessPhotoList.count
        case topicView.topic3:
            return architecturePhotoList.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(#function)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopicCollectionViewCell.id, for: indexPath) as! TopicCollectionViewCell
        
        switch collectionView {
        case topicView.topic1:
            cell.config(item: goldenHourPhotoList[indexPath.item])
            break
        case topicView.topic2:
            cell.config(item: businessPhotoList[indexPath.item])
            break
        case topicView.topic3:
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
        let group = DispatchGroup()
        
        switch collectionView {
        case topicView.topic1:
            group.enter()
            NetworkService.shared.callPhotoRequest(api: .detail(id: goldenHourPhotoList[indexPath.item].id), type: PhotoDetail.self, completion: { PhotoDetail in
                vc.photoDetail = PhotoDetail
                vc.givenPhotoInfo = self.goldenHourPhotoList[indexPath.item]
                group.leave()
            }, failureHandler: {
                self.showAlert(title: "이미지 로드 실패", message: $0.errors.debugDescription, handler: nil)
            })
    
            break
        case topicView.topic2:
            group.enter()
            NetworkService.shared.callPhotoRequest(api: .detail(id: businessPhotoList[indexPath.item].id), type: PhotoDetail.self, completion: { PhotoDetail in
                vc.photoDetail = PhotoDetail
                vc.givenPhotoInfo = self.businessPhotoList[indexPath.item]
                group.leave()
                
            }, failureHandler: {
                self.showAlert(title: "이미지 로드 실패", message: $0.errors.debugDescription, handler: nil)
            })
            break
        case topicView.topic3:
            group.enter()
            NetworkService.shared.callPhotoRequest(api: .detail(id: businessPhotoList[indexPath.item].id), type: PhotoDetail.self, completion: { PhotoDetail in
                vc.photoDetail = PhotoDetail
                vc.givenPhotoInfo = self.architecturePhotoList[indexPath.item]
                group.leave()
            }, failureHandler: {
                self.showAlert(title: "이미지 로드 실패", message: $0.errors.debugDescription, handler: nil)
            })
            break
        default:
            break
        }
        
        group.notify(queue: .main) {
            self.navigationController?.pushViewController(vc, animated: true)
        }

    }
}
