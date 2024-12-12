//
//  AnimeCellViewModel.swift
//  DatabaseAnimeApp
//
//  Created by Родион Холодов on 10.12.2024.
//

import Foundation

class AnimeCellViewModel {
    
    var id: Int
    var name: String
    var status: String
    var score: String
    var imageUrl: URL?
    
//    init(anime: AnimeModel) {
//        self.id = anime.id
//        self.name = anime.name
//        self.premiereDate = anime.premiere_date
//        self.score = "\(anime.score)/10"
//        self.imageUrl = makeImageUrl(anime)
//    }
    
    init(anime: AnimeModel) {
        self.id = anime.id
        self.name = anime.name
        
        // Проверка даты
        self.status = anime.status.isEmpty ? "Unknown," : anime.status + ","
        self.score = "\(anime.score)/10"
        self.imageUrl = makeImageUrl(anime)
    }

    private func makeImageUrl(_ anime: AnimeModel) -> URL? {
        // Создание URL
        if let url = URL(string: anime.image_url), !anime.image_url.isEmpty {
            return url
        } else {
            print("Invalid image URL in makeImageUrl AnimeCellViewModel")
            return nil
            
        }

    }
}
