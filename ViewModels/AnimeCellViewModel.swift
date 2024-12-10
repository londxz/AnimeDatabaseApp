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
    var premiereDate: String
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
        self.premiereDate = anime.premiere_date.isEmpty ? "Unknown" : anime.premiere_date
        
        // Проверка оценки
        self.score = "\(anime.score)/10"
        
        // Создание URL
        if let url = URL(string: anime.image_url), !anime.image_url.isEmpty {
            self.imageUrl = url
        } else {
            self.imageUrl = nil
            print("Invalid image URL: \(anime.image_url)")
        }
    }

    private func makeImageUrl(_ anime: AnimeModel) -> URL? {
        
        return URL(string: anime.image_url)
    }
}
