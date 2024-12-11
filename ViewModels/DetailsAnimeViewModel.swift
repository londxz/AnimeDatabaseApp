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
    var image: URL?
    
    init(anime: AnimeModel) {
        self.anime = anime
        
        self.name = anime.name
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
