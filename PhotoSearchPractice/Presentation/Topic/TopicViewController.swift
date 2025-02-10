//
//  TopicViewController.swift
//  PhotoSearchPractice
//
//  Created by BAE on 1/18/25.
//

import UIKit
import SnapKit
import Then


final class TopicViewController: BaseViewController {
    
    private let topicView = TopicView()
    
    let viewModel = TopicViewModel()
    
    override func loadView() {
        view = topicView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        viewModel.fetchTopicPhotos()
    }
    
    func bind() {
        viewModel.output.outputAlert.lazyBind { [weak self] errors in
            self?.showAlert(title: "로드 실패", message: errors.debugDescription, handler: nil)
        }
        viewModel.output.outputCollectionViewReload.lazyBind { [weak self] _ in
            self?.topicView.topic1.reloadData()
            self?.topicView.topic2.reloadData()
            self?.topicView.topic3.reloadData()
        }
        viewModel.output.outputSelectedPhoto.lazyBind { [weak self] photo in
            let vc = PhotoDetailViewController()
            if let photo {
                vc.viewModel.input.inputSelectedPhoto.value = photo
            } else {
                vc.viewModel.input.inputSelectedPhoto.value = PhotoResult.emptyPhoto()
            }
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func configView() {
        super.configView()
        self.navigationItem.title = "OUR TOPIC"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .automatic
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "person.circle"),
            primaryAction: UIAction(handler: { _ in
                let vc = ProfileViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }))
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
    
}

extension TopicViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case topicView.topic1:
            return viewModel.goldenHourPhotoList.count
        case topicView.topic2:
            return viewModel.businessPhotoList.count
        case topicView.topic3:
            return viewModel.architecturePhotoList.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(#function)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopicCollectionViewCell.id, for: indexPath) as! TopicCollectionViewCell
        
        switch collectionView {
        case topicView.topic1:
            cell.config(item: viewModel.goldenHourPhotoList[indexPath.item])
            break
        case topicView.topic2:
            cell.config(item: viewModel.businessPhotoList[indexPath.item])
            break
        case topicView.topic3:
            cell.config(item: viewModel.architecturePhotoList[indexPath.item])
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
        case topicView.topic1:
            viewModel.input.inputSelectedPhoto.value = viewModel.goldenHourPhotoList[indexPath.item]
            break
        case topicView.topic2:
            viewModel.input.inputSelectedPhoto.value = viewModel.businessPhotoList[indexPath.item]
            break
        case topicView.topic3:
            viewModel.input.inputSelectedPhoto.value = viewModel.architecturePhotoList[indexPath.item]
            break
        default:
            break
        }
    }
}
