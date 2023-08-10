//
//  Search response.swift
//  
//
//  Created by Владимир Бурлинов on 17.09.2022.
//

import Foundation

struct Welcome: Codable {
    let keyword: String
    let pagesCount, searchFilmsCountResult: Int
    var films: [Film]
    
     init(keyword: String,
                 pageCount: Int,
                 searchFilmsCountResult: Int,
                 films: [Film]) {
        self.keyword = keyword
        self.pagesCount = pageCount
        self.searchFilmsCountResult = searchFilmsCountResult
        self.films = films
    }
}


    // MARK: - Welcome
struct Film: Codable {
    let filmID: Int
    let nameRu, nameEn, type, year: String
    let description, filmLength: String
    let countries: [Country]
    let genres: [Genre]
    let rating: String
    let ratingVoteCount: Int
    let posterURL: String
    let posterURLPreview: String

    enum CodingKeys: String, CodingKey {
        case filmID = "filmId"
        case nameRu, nameEn, type, year, description, filmLength, countries, genres, rating, ratingVoteCount
        case posterURL = "posterUrl"
        case posterURLPreview = "posterUrlPreview"
    }
    
    init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: CodingKeys.self)
           filmID = try container.decode(Int.self, forKey: .filmID)
           nameRu = try container.decodeIfPresent(String.self, forKey: .nameRu) ?? ""
           nameEn = try container.decodeIfPresent(String.self, forKey: .nameEn) ?? ""
           type = try container.decodeIfPresent(String.self, forKey: .type) ?? ""
           year = try container.decodeIfPresent(String.self, forKey: .year) ?? ""
           description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
           filmLength = try container.decodeIfPresent(String.self, forKey: .filmLength) ?? ""
           countries = try container.decode([Country].self, forKey: .countries)
           genres = try container.decode([Genre].self, forKey: .genres)
           rating = try container.decodeIfPresent(String.self, forKey: .rating) ?? ""
           ratingVoteCount = try container.decodeIfPresent(Int.self, forKey: .ratingVoteCount) ?? 0
           posterURL = try container.decodeIfPresent(String.self, forKey: .posterURL) ?? ""
           posterURLPreview = try container.decodeIfPresent(String.self, forKey: .posterURLPreview) ?? ""
       }

}

// MARK: - Country
struct Country: Codable {
    let country: String
}

// MARK: - Genre
struct Genre: Codable {
    let genre: String
}

