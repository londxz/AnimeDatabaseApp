//
//  AnimeTypeEnum.swift
//  DatabaseAnimeApp
//
//  Created by Родион Холодов on 05.12.2024.
//

enum AnimeType: String {
    case tv = "TV"
    case movie = "Movie"
    case ova = "OVA"
    case ona = "ONA"
    case other = "Other"
    case unknown = "Unknown type"
}

enum AnimeStatus: String {
    case announced = "Announced"
    case airing = "Airing"
    case finished = "Finished"
    case discontinued = "Discontinued"
    case unknown = "Unknown status"
}
