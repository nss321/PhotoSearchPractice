//
//  PhotoDetailViewModel.swift
//  PhotoSearchPractice
//
//  Created by BAE on 2/10/25.
//

final class PhotoDetailViewModel: BaseViewModel {
    var selectedPhoto: PhotoResult? {
        input.inputSelectedPhoto.value
    }
    
    struct Input {
        let inputSelectedPhoto: Observable<PhotoResult?> = .init(nil)
    }
    
    struct Output {
        let outputPhotoDetail: Observable<PhotoDetail?> = .init(nil)
        let outputAlert: Observable<[String]> = .init([])
    }
    
    let input: Input
    let output: Output
    
    init() {
        input = Input()
        output = Output()
        transform()
    }
    
    func transform() {
        input.inputSelectedPhoto.bind { [weak self] photo in
            if let id = photo?.id, id != "" {
                self?.callPhotoDetail(id: id)
            } else {
                self?.output.outputPhotoDetail.value = PhotoDetail(
                    id: "id 정보를 불러올 수 없음.",
                    downloads: PhotoDetailDownloads(total: 0, historical: nil),
                    views: PhotoDetailViews(total: 0, historical: nil))
            }
        }
    }
    
    func callPhotoDetail(id: String) {
        NetworkService.shared.callPhotoRequest(api: .detail(id: id), type: PhotoDetail.self) { [weak self] detail in
            self?.output.outputPhotoDetail.value = detail
        } failureHandler: { [weak self] errors in
            self?.output.outputAlert.value = errors.errors
        }

    }
}
