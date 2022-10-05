//
//  Network data fetchure.swift
//  M18homework
//
//  Created by Владимир Бурлинов on 19.09.2022.
//

import Foundation

class NetworkDataFetcher {
    
    let networkService = NetWorkService()
    
    func fetchData(urlString: String, response: @escaping (Welcome?) -> Void) {
        networkService.request(urlString: urlString) { (result) in
            switch result {
                
            case .success(let data):
                do {
                    let movies = try JSONDecoder().decode(Welcome.self,
                        from: data)
                    response(movies)
                    
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                    response(nil)
                }
            case .failure(_):
                response(nil)
            }
        }
    }
}
