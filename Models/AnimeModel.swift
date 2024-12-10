//
//  AnimeModel.swift
//  DatabaseAnimeApp
//
//  Created by Родион Холодов on 10.12.2024.
//

import Foundation

struct AnimeModel: Codable {
    let id: Int
    let name: String
    let studio: String
    let synopsis: String
    let image_url: String
    let premiere_date: String
    let finale_date: String
    let num_episodes: Int
    let score: Double
    let genre: String
    let type: String
    let status: String
    let updated_at: String
}
