//
//  NetworkService.swift
//  PhotoSearchPractice
//
//  Created by BAE on 1/19/25.
//

import UIKit
import Alamofire

class NetworkService {
    
    static let shared = NetworkService()
    
    private let header: HTTPHeaders = [
        "Authorization" : APIKeys.photoSearchAPI
    ]
    
    func searchPhotos(keyword: String, completion: @escaping(Photo) -> Void) {
        let url = Urls.photoSearch(keyword: keyword)
        
        AF.request(url, method: .get, headers: header).responseDecodable(of: Photo.self) { response in
            switch response.result {
            case .success(let value):
                dump(value)
                completion(value)
                break
            case .failure(let error):
                print(error)
                if let errorData = response.data {
                    do {
                        let errorMessage = try JSONDecoder().decode(PhotoSearchError.self, from: errorData)
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
