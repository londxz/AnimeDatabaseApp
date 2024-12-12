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
    
    lazy var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    lazy var name: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Verdana-Bold", size: 20)
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
        synop.font = UIFont(name: "Verdana-Italic", size: 15)
        synop.translatesAutoresizingMaskIntoConstraints = false
        
       return synop
    }()
    
    lazy var synopsisLabel: UILabel = {
        let synop = UILabel()
        synop.text = "Synopsis:"
        synop.font = UIFont(name: "Verdana-Bold", size: 16)
        synop.translatesAutoresizingMaskIntoConstraints = false
        
       return synop
    }()
    
    lazy var informationLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Information"
        lbl.font = UIFont(name: "Verdana-Bold", size: 17)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        return lbl
    }()
    
    lazy var animeType: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "PingFangTC-Medium", size: 15)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        return lbl
    }()
    
    lazy var typeLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Type: "
        lbl.font = UIFont(name: "Verdana-Bold", size: 16)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        return lbl
    }()
}
