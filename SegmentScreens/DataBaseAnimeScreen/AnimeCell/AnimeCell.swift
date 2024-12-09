//
//  AnimeCell.swift
//  DatabaseAnimeApp
//
//  Created by Родион Холодов on 09.12.2024.
//

import UIKit
import SDWebImage

class AnimeCell: UITableViewCell {
    
    private let build = AnimeCellView()
    
    public static var identifier: String {
        get {
            return "AnimeCell"
        }
    }
    
}
