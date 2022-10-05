//
//  Network service.swift
//  
//
//  Created by Владимир Бурлинов on 18.09.2022.
//

import Foundation

class NetWorkService {

func request(urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {               //новый тип "Result"
    guard let url = URL(string: urlString) else { return }
    
    URLSession.shared.dataTask(with: url) { data, response, error in                        //запрашиваем данные
        DispatchQueue.main.async {
            if let error = error {
                //completion(nil, error)
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            completion(.success(data))
        }
      }.resume()
    }
}
