//
//  AnimeFuncsScreenView.swift
//  DatabaseAnimeApp
//
//  Created by Родион Холодов on 15.12.2024.
//

import Foundation
import UIKit
class AnimeFuncsScreenView {
    
    // make it singleton
    static let shared = AnimeFuncsScreenView()
    private init() {}
    
    lazy var addAnimeButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .failPurple
        btn.setTitleColor(.white, for: .normal)
        btn.setTitle(":3", for: .highlighted)
        btn.titleLabel?.font = UIFont(name: "Verdana-Bold", size: 16)
        btn.setTitle("Add anime", for: .normal)
        btn.layer.cornerRadius = 12
        return btn
    }()
    
    lazy var addGenreButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .white
        btn.setTitleColor(.failPurple, for: .normal)
        btn.setTitle(":-P", for: .highlighted)
        btn.titleLabel?.font = UIFont(name: "Verdana-Bold", size: 16)
        btn.setTitle("Add genre", for: .normal)

        btn.layer.borderWidth = 2
        btn.layer.borderColor = UIColor.failPurple.cgColor
        btn.layer.cornerRadius = 12
        return btn
    }()
    
    lazy var addStudioButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .failPurple
        btn.setTitleColor(.white, for: .normal)
        btn.setTitle("}:->", for: .highlighted)
        btn.titleLabel?.font = UIFont(name: "Verdana-Bold", size: 16)
        btn.setTitle("Add studio", for: .normal)
        btn.layer.cornerRadius = 12
        return btn
    }()
    
    lazy var addAnimeNameButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .white
        btn.setTitleColor(.failPurple, for: .normal)
        btn.setTitle("))", for: .highlighted)
        btn.titleLabel?.font = UIFont(name: "Verdana-Bold", size: 16)
        btn.setTitle("Add anime names", for: .normal)

        btn.layer.borderWidth = 2
        btn.layer.borderColor = UIColor.failPurple.cgColor
        btn.layer.cornerRadius = 12
        return btn
    }()
    
    lazy var addCharacterButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .failPurple
        btn.setTitleColor(.white, for: .normal)
        btn.setTitle("*_*", for: .highlighted)
        btn.titleLabel?.font = UIFont(name: "Verdana-Bold", size: 16)
        btn.setTitle("Add character", for: .normal)
        btn.layer.cornerRadius = 12
        return btn
    }()
}
