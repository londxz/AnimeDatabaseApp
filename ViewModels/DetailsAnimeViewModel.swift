//
//  DetailsAnimeViewModel.swift
//  DatabaseAnimeApp
//
//  Created by Родион Холодов on 11.12.2024.
//

import Foundation

class DetailsAnimeViewModel {
    
    var anime: AnimeModel
    var name: String
    var synopsis: String
    var studio: String
    var premiereDate: String
    var finalDate: String
    var numEpisodes: Int
    var genre: String
    var type: String
    var updatedAt: String
    var image: URL?
    
    init(anime: AnimeModel) {
        self.anime = anime
        
        self.name = anime.name
        self.synopsis = anime.synopsis
        self.studio = anime.studio
        self.premiereDate = anime.premiere_date
        self.finalDate = anime.finale_date
        self.numEpisodes = anime.num_episodes
        self.genre = anime.genre
        self.type = anime.type
        self.updatedAt = anime.updated_at
        self.image = makeImageUrl(anime.image_url)
    }
    
    private func makeImageUrl(_ imageSrt: String) -> URL? {
        
        if let url = URL(string: imageSrt), !imageSrt.isEmpty {
            return url
        } else {
            print("Invalid image URL in makeImageUrl DetailsAnimeViewModel")
            return nil
        }
    }
    
    
}
