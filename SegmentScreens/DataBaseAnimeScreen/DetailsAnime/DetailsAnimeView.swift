//
//  DetailsAnimeView.swift
//  DatabaseAnimeApp
//
//  Created by Родион Холодов on 11.12.2024.
//

import UIKit

class DetailsAnimeView {
    
    static let shared = DetailsAnimeView()
    private init() {}
    
    let titleSize: CGFloat = 20.0
    let textSize: CGFloat = 17.5
    
    lazy var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    lazy var name: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Verdana-Bold", size: 24)
        lbl.numberOfLines = 0
        lbl.textAlignment = .justified
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        return lbl
    }()
    
    lazy var goBackButton: UIButton = {
        let btn = UIButton()
        
        btn.setImage(UIImage(systemName: "xmark"), for: .normal)
        //btn.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        btn.tintColor = .black
        btn.alpha = 0.3
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }()
    
    lazy var synopsis: UILabel = {
        let synop = UILabel()
        synop.baselineAdjustment = .alignCenters
        synop.textAlignment = .justified
        synop.numberOfLines = 0
        synop.font = UIFont(name: "Verdana-Italic", size: textSize)
        synop.translatesAutoresizingMaskIntoConstraints = false
        
       return synop
    }()
    
    lazy var synopsisLabel: UILabel = {
        let synop = UILabel()
        synop.text = "Synopsis:"
        synop.font = UIFont(name: "Verdana-Bold", size: titleSize)
        synop.translatesAutoresizingMaskIntoConstraints = false
        
       return synop
    }()
    
    lazy var informationLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Information"
        lbl.font = UIFont(name: "Verdana-Bold", size: 22)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        return lbl
    }()
    
    lazy var animeType: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "PingFangTC-Medium", size: textSize)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        return lbl
    }()
    
    lazy var typeLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Type: "
        lbl.font = UIFont(name: "Verdana-Bold", size: titleSize)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        return lbl
    }()
    
    lazy var episodes: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "PingFangTC-Medium", size: textSize)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var episodesLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Episodes: "
        lbl.font = UIFont(name: "Verdana-Bold", size: titleSize)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var aired: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "PingFangTC-Medium", size: textSize)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var airedLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Aired: "
        lbl.font = UIFont(name: "Verdana-Bold", size: titleSize)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var studio: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "PingFangTC-Medium", size: textSize)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var studioLable: UILabel = {
        let lbl = UILabel()
        lbl.text = "Studio: "
        lbl.font = UIFont(name: "Verdana-Bold", size: titleSize)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var genre: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "PingFangTC-Medium", size: textSize)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var genreLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Genre: "
        lbl.font = UIFont(name: "Verdana-Bold", size: titleSize)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var charactersLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Characters: "
        lbl.font = UIFont(name: "Verdana-Bold", size: titleSize)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var charactersQuestionButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "questionmark.app"), for: .normal)
        btn.tintColor = .black
        //btn.alpha = 0.3
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }()
    
    lazy var genreQuestionButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "questionmark.app"), for: .normal)
        btn.tintColor = .black
        //btn.alpha = 0.3
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }()
    
    lazy var studioQuestionButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "questionmark.app"), for: .normal)
        btn.tintColor = .black
        //btn.alpha = 0.3
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }()
    
    lazy var otherNamesQuestionButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "questionmark.app"), for: .normal)
        btn.tintColor = .black
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }()
    
    lazy var id: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "PingFangTC-Medium", size: textSize)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var idLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Id: "
        lbl.font = UIFont(name: "Verdana-Bold", size: titleSize)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var lastChange: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "PingFangTC-Medium", size: textSize)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var lastChangeLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Updated: "
        lbl.font = UIFont(name: "Verdana-Bold", size: titleSize)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var otherNamesLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Other names: "
        lbl.font = UIFont(name: "Verdana-Bold", size: titleSize)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
}
