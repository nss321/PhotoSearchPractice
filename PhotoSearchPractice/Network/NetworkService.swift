//
//  NetworkService.swift
//  PhotoSearchPractice
//
//  Created by BAE on 1/19/25.
//

import UIKit
import Alamofire

enum SearchPhotoRequest {
    case search(query: String, page: Int = 1, per_page: Int = 20)
    case orderedSearch(query: String, orderBy: Bool, page: Int = 1, per_page: Int = 20)
    case colorFileteredSearch(query: String, color:String, page: Int = 1, per_page: Int = 20)
    case topic
    case detail
    
    var baseURL: String {
        return Urls.baseURL()
    }
    
    var endpoint: URL {
        
        switch self {
        case let .search(query, page, per_page):
            return URL(string: self.baseURL + "search/photos?query=\(query)&page=\(page)&per_page=\(per_page)")!
        case let .orderedSearch(query, orderBy, page, per_page):
            return URL(string: self.baseURL + "search/photos?query=\(query)&page=\(page)&per_page=\(per_page)&order_by=\(orderBy ? "latest" : "relevant")")!
        case let .colorFileteredSearch(query, color, page, per_page):
            return URL(string: self.baseURL + "search/photos?query=\(query)&page=\(page)&per_page=\(per_page)&color=\(color)")!
        case .topic:
            return URL(string: self.baseURL + "photos/")!
        case .detail:
            return URL(string: self.baseURL + "")!
        }
    }
    
    var header: HTTPHeaders {
        return ["Authorization": APIKeys.photoSearchAPI]
    }
    
    var method: HTTPMethod {
        return .get
    }
    
//    var parameter: Parameters {
//        return ["page":"1", "color":"white","order_by":"relevant"]
//    }
    
}

final class NetworkService {
    
    static let shared = NetworkService()
    
    private let header: HTTPHeaders = [
        "Authorization" : APIKeys.photoSearchAPI
    ]
    
    func searchPhotos(
        api: SearchPhotoRequest,
        completion: @escaping(Photo) -> Void) {
        
            AF.request(api.endpoint,
                       method: api.method,
                       headers: api.header).responseDecodable(of: Photo.self) { response in
            switch response.result {
            case .success(let value):
                completion(value)
                break
            case .failure(let error):
                print(error)
                if let errorData = response.data {
                    do {
                        let errorMessage = try JSONDecoder().decode(UnplashErrorMessage.self, from: errorData)
                        print(errorMessage)
                    } catch {
                        print("catched")
                    }
                } else {
                    print("failed unwrapping errorData")
                }
            }
        }
    }
    
    func orderedSearchPhotos(api: SearchPhotoRequest,
                             completion: @escaping(Photo) -> Void) {
        AF.request(api.endpoint,
                   method: api.method,
                   headers: api.header).responseDecodable(of: Photo.self) { response in
            switch response.result {
            case .success(let value):
//                dump(value)
                completion(value)
                break
            case .failure(let error):
                print(error)
                if let errorData = response.data {
                    do {
                        let errorMessage = try JSONDecoder().decode(UnplashErrorMessage.self, from: errorData)
                        print(errorMessage)
                    } catch {
                        print("catched")
                    }
                } else {
                    print("failed unwrapping errorData")
                }
            }
        }
    }
    
    func topicPhotos(topic: Topic, completion: @escaping([PhotoResult]) -> Void) {
        let url = Urls.topicSearch(topic: topic)
        print("============",#function,"============")
        AF.request(url, method: .get, headers: header).responseDecodable(of: [PhotoResult].self) { response in
            switch response.result {
            case .success(let value):
                completion(value)
                break
            case .failure(let error):
                print(error)
                if let errorData = response.data {
                    do {
                        let errorMessage = try JSONDecoder().decode(UnplashErrorMessage.self, from: errorData)
                        print(errorMessage)
                    } catch {
                        print("catched")
                    }
                } else {
                    print("failed unwrapping errorData")
                }
            }
        }
    }
    
    func photoDetail(id: String, completion: @escaping(PhotoDetail) -> Void) {
        let url = Urls.photoDetail(id: id)
        print("============",#function,"============")
        AF.request(url, method: .get, headers: header)
            .responseDecodable(of: PhotoDetail.self) { response in
            switch response.result {
            case .success(let value):
                completion(value)
                break
            case .failure(let error):
                print(error)
                if let errorData = response.data {
                    do {
                        let errorMessage = try JSONDecoder().decode(UnplashErrorMessage.self, from: errorData)
                        print(errorMessage)
                    } catch {
                        print("catched")
                    }
                } else {
                    print("failed unwrapping errorData")
                }
            }
        }
    }
    
}
