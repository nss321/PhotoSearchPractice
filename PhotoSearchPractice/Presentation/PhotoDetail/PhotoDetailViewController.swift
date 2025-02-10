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

final class PhotoDetailViewController: BaseViewController {
    var givenPhotoInfo: PhotoResult?
    var photoDetail: PhotoDetail?
    
    let photoDetailView = PhotoDetailView()
    var viewModel = PhotoDetailViewModel()
    
    override func loadView() {
        view = photoDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    private func bind() {
        viewModel.output.outputPhotoDetail.lazyBind { [weak self] photoDetail in
            self?.photoDetailView.configView(
                photo: self?.viewModel.selectedPhoto,
                photoStatus: photoDetail
            )
        }
        viewModel.output.outputAlert.lazyBind { [weak self] errors in
            self?.showAlert(title: "로드 실패", message: errors.debugDescription, handler: nil)
        }
    }
    
    override func configView() {
        super.configView()
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left")?.withTintColor(.black, renderingMode: .alwaysOriginal),
            primaryAction: UIAction(handler: { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            })
        )
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
}

extension PhotoDetailViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return navigationController?.viewControllers.count ?? 0 > 1
    }
}
