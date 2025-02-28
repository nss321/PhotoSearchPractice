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
    case topic(topic: Topic)
    case detail(id: String)
    
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
        case .topic(let topic):
            return URL(string: self.baseURL + "topics/\(topic.rawValue)/photos?")!
        case .detail(let id):
            return URL(string: self.baseURL + "photos/\(id)/statistics")!
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
    
    func callPhotoRequest<T: Decodable>(
        api: SearchPhotoRequest,
        type: T.Type,
        completion: @escaping(T) -> Void,
        failureHandler: @escaping(UnplashErrorMessage) -> Void
    ) {
        AF.request(api.endpoint,
                   method: api.method,
                   headers: api.header)
            .responseDecodable(of: T.self) { response in
//                debugPrint(response)
//                response.response?.statusCode
            switch response.result {
            case .success(let value):
                completion(value)
                break
            case .failure(let error):
//                print(error)
                if let errorData = response.data {
                    do {
                        let errorMessage = try JSONDecoder().decode(UnplashErrorMessage.self, from: errorData)
                        failureHandler(errorMessage)
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
