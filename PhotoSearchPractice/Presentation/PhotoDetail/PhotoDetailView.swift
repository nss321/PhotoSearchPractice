//
//  PhotoDetailView.swift
//  PhotoSearchPractice
//
//  Created by BAE on 1/22/25.
//

import UIKit
import Kingfisher
import SnapKit
import Then

final class PhotoDetailView: UIView {
    
    private let verticalScrollView = UIScrollView()
    private let profileImage = UIImageView()
    private let userNameLabel = UILabel()
    private let createdDateLabel = UILabel()
    private let photoDetailImage = UIImageView()
    private let infoLabel = UILabel()
    private let photoSizeInfoLabel = UILabel()
    private let photoSizeLabel = UILabel()
    private let photoViwesInfoLabel = UILabel()
    private let photoViwes = UILabel()
    private let photoDownloadsInfoLabel = UILabel()
    private let photoDownloads = UILabel()
    private let chartLabel = UILabel()
    private let chartSegment = UISegmentedControl()
    private let container = UIView()
    
    private var photo: PhotoResult?
    private var photoStatus: PhotoDetail?

    init(photo: PhotoResult? = nil, status: PhotoDetail? = nil) {
        super.init(frame: .zero)
        configHierarchy()
        configLayout()
        configView(photo: photo, photoStatus: status)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configHierarchy() {
        addSubview(verticalScrollView)
        verticalScrollView.addSubview(container)
        [profileImage ,userNameLabel ,createdDateLabel ,photoDetailImage ,infoLabel ,photoSizeLabel ,photoViwes ,photoDownloads ,chartLabel ,chartSegment, photoSizeInfoLabel ,photoViwesInfoLabel ,photoDownloadsInfoLabel].forEach { container.addSubview($0) }
    }
    
    private func configLayout() {
        verticalScrollView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
        
        container.snp.makeConstraints {
            $0.edges.equalTo(verticalScrollView.contentLayoutGuide)
            $0.width.equalTo(verticalScrollView.frameLayoutGuide)
        }
        
        profileImage.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(12)
            $0.width.height.equalTo(32)
        }
        
        // TODO: 오토레이아웃 코드 가이드? 찾아보기(e.g. 최대한 계산 적게 코드를 짜야한
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
            $0.horizontalEdges.equalToSuperview()
        }

        infoLabel.snp.makeConstraints {
            $0.top.equalTo(photoDetailImage.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
        }
        
        photoSizeInfoLabel.snp.makeConstraints {
            $0.centerY.equalTo(infoLabel.snp.centerY)
            $0.leading.equalTo(infoLabel.snp.trailing).offset(50)
        }
        
        photoSizeLabel.snp.makeConstraints {
            $0.centerY.equalTo(infoLabel.snp.centerY)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        photoViwesInfoLabel.snp.makeConstraints {
            $0.top.equalTo(photoSizeInfoLabel.snp.bottom).offset(16)
            $0.leading.equalTo(photoSizeInfoLabel)
        }
        photoViwes.snp.makeConstraints {
            $0.centerY.equalTo(photoViwesInfoLabel.snp.centerY)
            $0.trailing.equalToSuperview().inset(16)
        }
        photoDownloadsInfoLabel.snp.makeConstraints {
            $0.top.equalTo(photoViwesInfoLabel.snp.bottom).offset(16)
            $0.leading.equalTo(photoSizeInfoLabel)
        }
        photoDownloads.snp.makeConstraints {
            $0.centerY.equalTo(photoDownloadsInfoLabel.snp.centerY)
            $0.trailing.equalToSuperview().inset(16)
        }
        chartLabel.snp.makeConstraints {
            $0.leading.equalTo(infoLabel)
            $0.top.equalTo(photoDownloadsInfoLabel.snp.bottom).offset(20)
            $0.bottom.greaterThanOrEqualToSuperview().inset(60)
        }
    }
    
    func configView(photo: PhotoResult?, photoStatus: PhotoDetail?) {
        backgroundColor = .systemBackground
        
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
