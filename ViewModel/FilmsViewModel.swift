//
//  FilmsViewModel.swift
//  M18homework
//
//  Created by Владимир Бурлинов on 07.08.2023.
//

import Foundation

protocol FilmsViewModelDelegate: AnyObject {
    func didUpdateFilms()
}


class FilmsViewModel {
    
    private let networkManager = NetworkDataFetcher()
    
    var films: [Film] = [] {
        didSet {
                   delegate?.didUpdateFilms()
               }

    }
    
    weak var delegate: FilmsViewModelDelegate?

        
    func fetchFilms(urlString: String, response: @escaping (Welcome?) -> Void) {
        networkManager.fetchData(urlString: urlString) { [weak self] films in
            
        
            guard let films = films else {
                return
            }
            self?.films.append(contentsOf: films.films)
            print("Count: \(self?.films.count)")
        }
    }
}
