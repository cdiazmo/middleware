//
//  JokeDataModel.swift
//  
//
//  Created by Carlos Diaz on 9/7/22.
//

import Foundation

// MARK: - JokeDataModel
class JokeDataModel: Codable {
    let categories: [String]?
    let createdAt: String
    let iconURL: String
    let id, updatedAt: String
    let url: String
    let value: String

    enum CodingKeys: String, CodingKey {
        case categories
        case createdAt = "created_at"
        case iconURL = "icon_url"
        case id
        case updatedAt = "updated_at"
        case url, value
    }

    init(categories: [String]?, createdAt: String, iconURL: String, id: String, updatedAt: String, url: String, value: String) {
        self.categories = categories
        self.createdAt = createdAt
        self.iconURL = iconURL
        self.id = id
        self.updatedAt = updatedAt
        self.url = url
        self.value = value
    }
}
