//
//  Character.swift
//  Marvel
//
//  Created by Monika Saini on 10/03/22.
//  Copyright © 2022 capgemini. All rights reserved.
//

import Foundation

// MARK: - Character
struct Character: Codable {
    let id: Int?
    let name, description: String?
    let thumbnail: Thumbnail?
   
    private enum RootKeys: String, CodingKey {
        case id, name
        case description
        case thumbnail
    }
}

// MARK: - CharactersList
struct CharactersList: Decodable {
    var results: [Character]

    private enum CodingKeys: String, CodingKey {
        case data
    }

    private enum DataCodingKeys: String, CodingKey {
        case results
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let data = try container.nestedContainer(keyedBy: DataCodingKeys.self, forKey: .data)
        results = try data.decode([Character].self, forKey: .results)
        print(results.count)
    }
}


// MARK: - Thumbnail
struct Thumbnail: Codable {
    let path: String
    let thumbnailExtension: Extension

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

enum Extension: String, Codable {
    case gif = "gif"
    case jpg = "jpg"
}

