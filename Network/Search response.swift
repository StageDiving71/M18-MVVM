//
//  Search response.swift
//  
//
//  Created by Владимир Бурлинов on 17.09.2022.
//

import Foundation


    // MARK: - Welcome
    struct Welcome: Codable {
        let searchType: SearchTypeEnum
        let expression: String
        let results: [Result1]
        let errorMessage: String
    }

    // MARK: - Result
    struct Result1: Codable {
        let id: String
        let resultType: SearchTypeEnum
        let image: String
        let title, resultDescription: String

        enum CodingKeys: String, CodingKey {
            case id, resultType, image, title
            case resultDescription = "description"
        }
    }

    enum SearchTypeEnum: String, Codable {
        case title = "Title"
    }
