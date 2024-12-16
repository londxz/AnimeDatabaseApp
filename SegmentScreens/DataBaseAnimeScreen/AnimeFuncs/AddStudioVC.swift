//
//  AddStudioVC.swift
//  DatabaseAnimeApp
//
//  Created by Родион Холодов on 16.12.2024.
//

import Foundation
import UIKit

class AddStudioVC: UIViewController {
    
    let classForGetTextView = AnimeFuncsScreenController()
    
    var nameTextField = UITextField()
    var descriptionTextField = UITextField()
    
    override func viewDidLoad() {
        view.backgroundColor = .detailsWhite

        setBannerImage()
        setTextViews()
    }
    
    lazy var addStudioButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .detailsWhite
        btn.setTitleColor(.failPurple, for: .normal)
        btn.setTitle("о_О", for: .highlighted)
        btn.titleLabel?.font = UIFont(name: "Verdana-Bold", size: 16)
        btn.setTitle("Add studio", for: .normal)

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
        bannerImage.image = .anime1
        
        
        NSLayoutConstraint.activate([
            bannerImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bannerImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 50)
        ])
    }
    
    private func setTextViews() {
        let nameStack = classForGetTextView.getTextView(textField: nameTextField, placeholder: "Studio")
        let descriptionStack = classForGetTextView.getTextView(textField: descriptionTextField, placeholder: "Studio description")
        
        addStudioButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addStudioButton)
        
        view.addSubview(nameStack)
        view.addSubview(descriptionStack)
        
        NSLayoutConstraint.activate([
            nameStack.topAnchor.constraint(equalTo: bannerImage.bottomAnchor, constant: 30),
            nameStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            
            descriptionStack.topAnchor.constraint(equalTo: nameStack.bottomAnchor, constant: 10),
            descriptionStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            
            addStudioButton.topAnchor.constraint(equalTo: descriptionStack.bottomAnchor, constant: 20),
            addStudioButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addStudioButton.widthAnchor.constraint(equalToConstant: 200),
            addStudioButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
