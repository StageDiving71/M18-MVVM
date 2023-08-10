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
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.allHTTPHeaderFields = ["X-API-KEY":"a11df75f-4b3b-4f84-beda-d479f14ce236"] //"Content-Type": "application/json"]
    
    URLSession.shared.dataTask(with: request) { data, response, error in                        //запрашиваем данные
        DispatchQueue.main.async {
            print(response)
            print(try? JSONSerialization.jsonObject(with: data!, options: []))
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            completion(.success(data))
        }
      }.resume()
    }
}

