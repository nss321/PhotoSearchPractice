//
//  NetworkService.swift
//  PhotoSearchPractice
//
//  Created by BAE on 1/19/25.
//

import UIKit
import Alamofire

//enum SearchPhotoRequest {
//    case search
//    case orderedSearch(orderBy: Bool)
//    
//    var baseURL: String {
//        return "https://api.unsplash.com/"
//    }
//    
//    var endpoint: URL {
//        switch self {
//        case .search:
//            return URL(string: self.baseURL + "photos/random")!
//        case .orderedSearch(let orderBy):
//            return URL(string: self.baseURL + "topics/\(orderBy)")!
//        case .photo(let query):
//            return URL(string: self.baseURL + "photos/\(query)")!
//            
//        }
//    }
//    
//    var header: HTTPHeaders {
//        return ["Authorization": "Client-ID \(APIKeys.photoSearchAPI)"]
//    }
//    
//    var method: HTTPMethod {
//        return .get
//    }
//    
//    var parameter: Parameters {
//        return ["page":"1", "color":"white","order_by":"relevant"]
//    }
//    
//}


final class NetworkService {
    
    static let shared = NetworkService()
    
    private let header: HTTPHeaders = [
        "Authorization" : APIKeys.photoSearchAPI
    ]
    
    func searchPhotos(keyword: String, page: Int = 1, completion: @escaping(Photo) -> Void) {
        let url = Urls.photoSearch(keyword: keyword, page: page)
        
        AF.request(url, method: .get, headers: header).responseDecodable(of: Photo.self) { response in
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
    
    func orderedSearchPhotos(keyword: String, orderBy: Bool, completion: @escaping(Photo) -> Void) {
        let url = Urls.orderedSearch(keyword: keyword, orderBy: orderBy ? "latest" : "relevant")
        AF.request(url, method: .get, headers: header).responseDecodable(of: Photo.self) { response in
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
