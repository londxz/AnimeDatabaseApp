//
//  AddGenreVC.swift
//  DatabaseAnimeApp
//
//  Created by Родион Холодов on 16.12.2024.
//

import Foundation
import UIKit

class AddCharacterVC: UIViewController {
    
    let classForGetTextView = AnimeFuncsScreenController()
    
    var idTextField = UITextField()
    var nameTextField = UITextField()
    var animeIdTextField = UITextField()
    var descriptionTextField = UITextField()
    
    override func viewDidLoad() {
        view.backgroundColor = .detailsWhite

        setBannerImage()
        setTextViews()
    }
    
    lazy var addCharacterButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .detailsWhite
        btn.setTitleColor(.failPurple, for: .normal)
        btn.setTitle("о_О", for: .highlighted)
        btn.titleLabel?.font = UIFont(name: "Verdana-Bold", size: 16)
        btn.setTitle("Add character", for: .normal)

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
        bannerImage.image = .anime4
        
        
        NSLayoutConstraint.activate([
            bannerImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bannerImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 50)
        ])
    }
    
    private func setTextViews() {
        let idStack = classForGetTextView.getTextView(textField: idTextField, placeholder: "Character id")
        let nameStack = classForGetTextView.getTextView(textField: nameTextField, placeholder: "Character name")
        let animeIdStack = classForGetTextView.getTextView(textField: animeIdTextField, placeholder: "Anime id")
        let descriptionStack = classForGetTextView.getTextView(textField: descriptionTextField, placeholder: "Character description")
        
        addCharacterButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addCharacterButton)
        
        view.addSubview(idStack)
        view.addSubview(nameStack)
        view.addSubview(animeIdStack)
        view.addSubview(descriptionStack)
        
        NSLayoutConstraint.activate([
            idStack.topAnchor.constraint(equalTo: bannerImage.bottomAnchor, constant: 20),
            idStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            idStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            
            nameStack.topAnchor.constraint(equalTo: idStack.bottomAnchor, constant: 10),
            nameStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            
            animeIdStack.topAnchor.constraint(equalTo: nameStack.bottomAnchor, constant: 10),
            animeIdStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            animeIdStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            
            descriptionStack.topAnchor.constraint(equalTo: animeIdStack.bottomAnchor, constant: 10),
            descriptionStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            
            addCharacterButton.topAnchor.constraint(equalTo: descriptionStack.bottomAnchor, constant: 20),
            addCharacterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addCharacterButton.widthAnchor.constraint(equalToConstant: 200),
            addCharacterButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}


