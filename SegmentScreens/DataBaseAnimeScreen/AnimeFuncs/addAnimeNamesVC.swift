//
//  AddGenreVC.swift
//  DatabaseAnimeApp
//
//  Created by Родион Холодов on 16.12.2024.
//

import Foundation
import UIKit

class AddAnimeNamesVC: UIViewController {
    
    let classForGetTextView = AnimeFuncsScreenController()
    
    var nameTextField = UITextField()
    var descriptionTextField = UITextField()
    var romajiTextField = UITextField()
    
    override func viewDidLoad() {
        view.backgroundColor = .detailsWhite

        setBannerImage()
        setTextViews()
    }
    
    lazy var addAnimeNameButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .detailsWhite
        btn.setTitleColor(.failPurple, for: .normal)
        btn.setTitle("о_О", for: .highlighted)
        btn.titleLabel?.font = UIFont(name: "Verdana-Bold", size: 16)
        btn.setTitle("Add anime names", for: .normal)

        btn.layer.borderWidth = 2
        btn.layer.borderColor = UIColor.failPurple.cgColor
        btn.layer.cornerRadius = 12
        return btn
    }()

    lazy var bannerImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        
        NSLayoutConstraint.activate([
            image.widthAnchor.constraint(equalToConstant: 200),
            image.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        return image
    }()
    
    private func setBannerImage() {
        view.addSubview(bannerImage)
        bannerImage.image = .anime3
        
        
        NSLayoutConstraint.activate([
            bannerImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bannerImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 50)
        ])
    }
    
    private func setTextViews() {
        let idStack = classForGetTextView.getTextView(textField: nameTextField, placeholder: "Anime id")
        let japanStack = classForGetTextView.getTextView(textField: descriptionTextField, placeholder: "Japanese name")
        let romajiStack = classForGetTextView.getTextView(textField: romajiTextField, placeholder: "Romaji name")
        
        addAnimeNameButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addAnimeNameButton)
        
        view.addSubview(idStack)
        view.addSubview(japanStack)
        view.addSubview(romajiStack)
        
        NSLayoutConstraint.activate([
            idStack.topAnchor.constraint(equalTo: bannerImage.bottomAnchor, constant: 20),
            idStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            idStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            
            japanStack.topAnchor.constraint(equalTo: idStack.bottomAnchor, constant: 10),
            japanStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            japanStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            
            romajiStack.topAnchor.constraint(equalTo: japanStack.bottomAnchor, constant: 10),
            romajiStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            romajiStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            
            addAnimeNameButton.topAnchor.constraint(equalTo: romajiStack.bottomAnchor, constant: 20),
            addAnimeNameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addAnimeNameButton.widthAnchor.constraint(equalToConstant: 200),
            addAnimeNameButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}

