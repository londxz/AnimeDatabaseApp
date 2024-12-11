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
}
