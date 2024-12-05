//
//  Id.swift
//  DatabaseAnimeApp
//
//  Created by Родион Холодов on 05.12.2024.
//

class Id {
    
    static let shared = Id()
    
    var animeId = 1 {
        didSet {
            print("animeId изменился на \(animeId)")
        }
    }
    
    var characterId = 1 {
        didSet {
            print("characterId изменился на \(characterId)")
        }
    }
    
    private init() {}
}
