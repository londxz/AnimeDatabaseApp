//
//  AnimeCellView.swift
//  DatabaseAnimeApp
//
//  Created by Родион Холодов on 09.12.2024.
//

import UIKit

class AnimeCellView {
    
    lazy var backView: UIView  = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray6
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    lazy var nameLabel: UILabel = {
        var name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.font = .monospacedSystemFont(ofSize: 18, weight: .bold)
        name.textAlignment = .left
        name.numberOfLines = 0
        name.text = "Name"
        
        return name
    }()
    
    lazy var dateLabel: UILabel = {
        var date = UILabel()
        date.translatesAutoresizingMaskIntoConstraints = false
        date.font = .monospacedSystemFont(ofSize: 15, weight: .light)
        date.text = "06/66/6666"
        
        return date
    }()
    
    lazy var rateLabel: UILabel = {
        var rate = UILabel()
        rate.translatesAutoresizingMaskIntoConstraints = false
        rate.font = .monospacedSystemFont(ofSize: 15, weight: .medium)
        rate.text = "10/10"
        
        return rate
    }()
    
}
