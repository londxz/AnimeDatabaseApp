//
//  CharacterModel.swift
//  DatabaseAnimeApp
//
//  Created by Родион Холодов on 10.12.2024.
//

import Foundation

struct CharacterModel: Codable {
    let id: Int
    let name: String
    let anime_id: Int
    let description: String
}
