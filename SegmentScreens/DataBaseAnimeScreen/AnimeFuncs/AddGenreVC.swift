//
//  AddGenreVC.swift
//  DatabaseAnimeApp
//
//  Created by Родион Холодов on 16.12.2024.
//

import Foundation
import UIKit

class AddGenreVC: UIViewController {
    
    let classForGetTextView = AnimeFuncsScreenController()
    
    var nameTextField = UITextField()
    var descriptionTextField = UITextField()
    
    override func viewDidLoad() {
        view.backgroundColor = .detailsWhite

        setBannerImage()
        setTextViews()
    }
    
    lazy var addGenreButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .detailsWhite
        btn.setTitleColor(.failPurple, for: .normal)
        btn.setTitle("о_О", for: .highlighted)
        btn.titleLabel?.font = UIFont(name: "Verdana-Bold", size: 16)
        btn.setTitle("Add genre", for: .normal)

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
            image.widthAnchor.constraint(equalToConstant: 250),
            image.heightAnchor.constraint(equalToConstant: 250)
        ])
        
        return image
    }()
    
    private func setBannerImage() {
        view.addSubview(bannerImage)
        bannerImage.image = .welcomeIcon
        
        
        NSLayoutConstraint.activate([
            bannerImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bannerImage.topAnchor.constraint(equalTo: view.topAnchor)
        ])
    }
    
    private func setTextViews() {
        let nameStack = classForGetTextView.getTextView(textField: nameTextField, placeholder: "Genre")
        let descriptionStack = classForGetTextView.getTextView(textField: descriptionTextField, placeholder: "Genre description")
        
        addGenreButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addGenreButton)
        
        view.addSubview(nameStack)
        view.addSubview(descriptionStack)
        
        NSLayoutConstraint.activate([
            nameStack.topAnchor.constraint(equalTo: bannerImage.bottomAnchor, constant: 10),
            nameStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            
            descriptionStack.topAnchor.constraint(equalTo: nameStack.bottomAnchor, constant: 10),
            descriptionStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            
            addGenreButton.topAnchor.constraint(equalTo: descriptionStack.bottomAnchor, constant: 20),
            addGenreButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addGenreButton.widthAnchor.constraint(equalToConstant: 200),
            addGenreButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
