//
//  TopicViewModel.swift
//  PhotoSearchPractice
//
//  Created by BAE on 2/10/25.
//

import Foundation

enum Topic: String {
    case goldenHour = "golden-hour"
    case business = "business-work"
    case architecture = "architecture-interior"
    
    var topicID: String {
        rawValue
    }
}

class TopicViewModel: BaseViewModel {

    private(set) var goldenHourPhotoList = [PhotoResult]()
    private(set) var businessPhotoList = [PhotoResult]()
    private(set) var architecturePhotoList = [PhotoResult]()
    
    struct Input {
        let inputSelectedPhoto: Observable<PhotoResult?> = .init(nil)
    }
    
    struct Output {
        let outputAlert: Observable<[String]> = .init([])
        let outputCollectionViewReload: Observable<Void?> = .init(nil)
        let outputSelectedPhoto: Observable<PhotoResult?> = .init(nil)
     }
    
    let input: Input
    let output: Output
    
    init() {
        input = Input()
        output = Output()
        transform()
    }
    
    func transform() {
        input.inputSelectedPhoto.lazyBind { [weak self] photo in
            self?.output.outputSelectedPhoto.value = photo
        }
    }
    
    func fetchTopicPhotos() {
        let group = DispatchGroup()
        
        group.enter()
        NetworkService.shared.callPhotoRequest(api: .topic(topic: .goldenHour), type: [PhotoResult].self, completion: { [weak self] PhotoList in
            self?.goldenHourPhotoList = PhotoList
            group.leave()
        }, failureHandler: {
            self.output.outputAlert.value = $0.errors
        })
        group.enter()
        NetworkService.shared.callPhotoRequest(api: .topic(topic: .business), type: [PhotoResult].self, completion: { [weak self] PhotoList in
            self?.businessPhotoList = PhotoList
            group.leave()
        }, failureHandler: {
            self.output.outputAlert.value = $0.errors
        })

        group.enter()
        NetworkService.shared.callPhotoRequest(api: .topic(topic: .architecture), type: [PhotoResult].self, completion: { [weak self] PhotoList in
            self?.architecturePhotoList = PhotoList
            group.leave()
        }, failureHandler: {
            self.output.outputAlert.value = $0.errors
        })
        
        group.notify(queue: .main) {
            self.output.outputCollectionViewReload.value = ()
        }
    }
    
}
