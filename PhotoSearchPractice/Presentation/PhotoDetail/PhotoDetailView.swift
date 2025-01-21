//
//  PhotoDetailView.swift
//  PhotoSearchPractice
//
//  Created by BAE on 1/22/25.
//

import UIKit
import SnapKit
import Then

class PhotoDetailView: UIView {
    
    let verticalScrollView = UIScrollView()
    let profileImage = UIImageView()
    let userNameLabel = UILabel()
    let createdDateLabel = UILabel()
    let photoDetailImage = UIImageView()
    let infoLabel = UILabel()
    let photoSizeInfoLabel = UILabel()
    let photoSizeLabel = UILabel()
    let photoViwesInfoLabel = UILabel()
    let photoViwes = UILabel()
    let photoDownloadsInfoLabel = UILabel()
    let photoDownloads = UILabel()
    let chartLabel = UILabel()
    let chartSegment = UISegmentedControl()
    let group = DispatchGroup()
    var photo: PhotoResult?
    var photoStatus: PhotoDetail?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configHierarchy()
        configLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//    convenience init(photo: PhotoResult? = nil, status: PhotoDetail? = nil) {
//        self.init()
//        group.enter()
//        self.photo = photo
//        self.photoStatus = status
//        group.leave()
//        
//        group.notify(queue: .main) {
//            self.configView()
//            print("디스패치 실행")
//        }
//    }
//    
   
    
    func configHierarchy() {
        addSubview(verticalScrollView)
        [profileImage ,userNameLabel ,createdDateLabel ,photoDetailImage ,infoLabel ,photoSizeLabel ,photoViwes ,photoDownloads ,chartLabel ,chartSegment, photoSizeInfoLabel ,photoViwesInfoLabel ,photoDownloadsInfoLabel].forEach { verticalScrollView.addSubview($0) }
    }
    func configLayout() {
        verticalScrollView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
            $0.width.equalToSuperview()
        }
        
        profileImage.snp.makeConstraints {
            $0.top.leading.equalTo(verticalScrollView.contentLayoutGuide).inset(12)
            $0.width.height.equalTo(32)
        }
        
        userNameLabel.snp.makeConstraints {
            $0.leading.equalTo(profileImage.snp.trailing).offset(8)
            $0.top.equalTo(profileImage.snp.top).offset(2)
        }
        
        createdDateLabel.snp.makeConstraints {
            $0.top.equalTo(userNameLabel.snp.bottom)
            $0.leading.equalTo(profileImage.snp.trailing).offset(8)
            $0.bottom.equalTo(profileImage.snp.bottom).inset(2)
        }
        
        photoDetailImage.snp.makeConstraints {
            $0.top.equalTo(profileImage.snp.bottom).offset(12)
            $0.horizontalEdges.equalTo(verticalScrollView.contentLayoutGuide)
            $0.width.equalTo(verticalScrollView.frameLayoutGuide)
        }

        infoLabel.snp.makeConstraints {
            $0.top.equalTo(photoDetailImage.snp.bottom).offset(16)
            $0.leading.equalTo(verticalScrollView.contentLayoutGuide.snp.leading).offset(16)
        }
        
        photoSizeInfoLabel.snp.makeConstraints {
            $0.centerY.equalTo(infoLabel.snp.centerY)
            $0.leading.equalTo(infoLabel.snp.trailing).offset(50)
        }
        photoSizeLabel.snp.makeConstraints {
            $0.centerY.equalTo(infoLabel.snp.centerY)
            $0.trailing.equalTo(verticalScrollView.contentLayoutGuide.snp.trailing).inset(16)
        }
        
        photoViwesInfoLabel.snp.makeConstraints {
            $0.top.equalTo(photoSizeInfoLabel.snp.bottom).offset(16)
            $0.leading.equalTo(photoSizeInfoLabel)
        }
        photoViwes.snp.makeConstraints {
            $0.centerY.equalTo(photoViwesInfoLabel.snp.centerY)
            $0.trailing.equalTo(verticalScrollView.contentLayoutGuide.snp.trailing).inset(16)
        }
        photoDownloadsInfoLabel.snp.makeConstraints {
            $0.top.equalTo(photoViwesInfoLabel.snp.bottom).offset(16)
            $0.leading.equalTo(photoSizeInfoLabel)
        }
        photoDownloads.snp.makeConstraints {
            $0.centerY.equalTo(photoDownloadsInfoLabel.snp.centerY)
            $0.trailing.equalTo(verticalScrollView.contentLayoutGuide.snp.trailing).inset(16)
        }
        chartLabel.snp.makeConstraints {
            $0.leading.equalTo(infoLabel)
            $0.top.equalTo(photoDownloadsInfoLabel.snp.bottom).offset(20)
            $0.bottom.greaterThanOrEqualTo(verticalScrollView.contentLayoutGuide.snp.bottom).inset(60)
        }
    }
    
    func configView(photo: PhotoResult?, photoStatus: PhotoDetail?) {
        print(#function)
        
        guard let photo else {
            print("no photo")
            return
        }
        
        guard let photoStatus else {
            print("no photo detail")
            return
        }
        
        verticalScrollView.do {
            $0.showsVerticalScrollIndicator = false
            $0.backgroundColor = .clear
        }

        profileImage.do {
            $0.kf.setImage(with: URL(string: photo.user.profile_image.small))
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 16
        }
        userNameLabel.do {
            $0.text = photo.user.username
            $0.font = .preferredFont(forTextStyle: .footnote)
        }
        createdDateLabel.do {
            let date = DateManager.shared.convertDateToString(date: photo.created_at)
            $0.text = date
            $0.font = .preferredFont(forTextStyle: .caption2)
        }
        
        photoDetailImage.do {
            $0.contentMode = .scaleAspectFit
            $0.kf.setImage(with: URL(string: photo.urls.small))
        }
        infoLabel.do {
            $0.text = "정보"
            $0.font = .systemFont(ofSize: 16, weight: .black)
        }
        photoSizeInfoLabel.do {
            $0.text = "크기"
            $0.font = .systemFont(ofSize: 14, weight: .heavy)
        }
        photoSizeLabel.do {
            $0.text = "\(photo.width) x \(photo.height)"
            $0.font = .systemFont(ofSize: 14, weight: .regular)
        }
        
        photoViwesInfoLabel.do {
            $0.text = "조회수"
            $0.font = .systemFont(ofSize: 14, weight: .heavy)
        }
        
        photoDownloadsInfoLabel.do {
            $0.text = "다운로드"
            $0.font = .systemFont(ofSize: 14, weight: .heavy)
        }
        
        chartLabel.do {
            $0.text = "차트"
            $0.font = .systemFont(ofSize: 16, weight: .black)
        }
        
        photoViwes.do {
            $0.text = NumberFormatManager.shared.threeDigitComma(number: photoStatus.views.total)
            $0.font = .systemFont(ofSize: 14, weight: .regular)
        }
        photoDownloads.do {
            $0.text = NumberFormatManager.shared.threeDigitComma(number: photoStatus.downloads.total)
            $0.font = .systemFont(ofSize: 14, weight: .regular)
        }
    }
}
