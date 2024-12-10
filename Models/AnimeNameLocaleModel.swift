//
//  AnimeNameLocaleModel.swift
//  DatabaseAnimeApp
//
//  Created by Родион Холодов on 10.12.2024.
//

import Foundation

struct AnimeNameLocaleModel: Codable {
    let anime_id: Int
    let japanese_name: String
    let romaji_name: String
}
