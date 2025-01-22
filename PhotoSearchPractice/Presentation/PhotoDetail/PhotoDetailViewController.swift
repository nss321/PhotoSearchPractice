//
//  PhotoDetailViewController.swift
//  PhotoSearchPractice
//
//  Created by BAE on 1/19/25.
//

import UIKit
import Kingfisher
import SnapKit
import Then

class PhotoDetailViewController: BaseViewController {
    var givenPhotoInfo: PhotoResult?
    var photoDetail: PhotoDetail?
    
    override func loadView() {
        let photoDetailView = PhotoDetailView(photo: self.givenPhotoInfo, status: self.photoDetail)
        view = photoDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
//        photoDetailView.configView(photo: givenPhotoInfo, photoStatus: photoDetail)
//        view.addSubview(photoDetailView)
//        photoDetailView.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//        }
    }
    
    override func configView() {
        super.configView()
        self.navigationItem.largeTitleDisplayMode = .never
    
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left")?.withTintColor(.black, renderingMode: .alwaysOriginal),
            primaryAction: UIAction(handler: { _ in
                self.navigationController?.popViewController(animated: true)
            })
        )
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        
    }
}

extension PhotoDetailViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        print(navigationController?.viewControllers.count ?? 0 )
        return navigationController?.viewControllers.count ?? 0 > 1
    }
}
