//
//  JokeDataModel.swift
//  
//
//  Created by Carlos Diaz on 9/7/22.
//

import Foundation

// MARK: - JokeDataModel
class DadJokeDataModel: Codable {
    let id: String
    let status: String
    let joke: String

    enum CodingKeys: String, CodingKey {
        case status
        case id
        case joke
    }

    init(id: String, status: String, joke: String) {
        self.id = id
        self.status = status
        self.joke = joke
    }
}
