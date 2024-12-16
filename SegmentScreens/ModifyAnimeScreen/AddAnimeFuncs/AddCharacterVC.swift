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
    
    var nameTextField = UITextField()
    var animeIdTextField = UITextField()
    var descriptionTextField = UITextField()
    var characterDescriptionStack = UIStackView()
    
    override func viewDidLoad() {
        view.backgroundColor = .detailsWhite

        setBannerImage()
        setTextViews()
        
        setAddCharacterButton()
        
        setSuccessImage()
        setFailImage()
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
    
    lazy var successImage: UIImageView = {
        let image = UIImageView()
        image.image = .successLogin
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.alpha = 0
        
        NSLayoutConstraint.activate([
            image.widthAnchor.constraint(equalToConstant: 150),
            image.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        return image
    }()
    
    lazy var failImage: UIImageView = {
        let image = UIImageView()
        image.image = .failAdd
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.alpha = 0
        
        NSLayoutConstraint.activate([
            image.widthAnchor.constraint(equalToConstant: 150),
            image.heightAnchor.constraint(equalToConstant: 150)
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

        let nameStack = classForGetTextView.getTextView(textField: nameTextField, placeholder: "Character name")
        let animeIdStack = classForGetTextView.getTextView(textField: animeIdTextField, placeholder: "Anime id")
        characterDescriptionStack = classForGetTextView.getTextView(textField: descriptionTextField, placeholder: "Character description")
        
        view.addSubview(nameStack)
        view.addSubview(animeIdStack)
        view.addSubview(characterDescriptionStack)
        
        NSLayoutConstraint.activate([
            
            nameStack.topAnchor.constraint(equalTo: bannerImage.bottomAnchor, constant: 20),
            nameStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            
            animeIdStack.topAnchor.constraint(equalTo: nameStack.bottomAnchor, constant: 10),
            animeIdStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            animeIdStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            
            characterDescriptionStack.topAnchor.constraint(equalTo: animeIdStack.bottomAnchor, constant: 10),
            characterDescriptionStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            characterDescriptionStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20)
            
        ])
    }
    
    private func setAddCharacterButton() {
        addCharacterButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addCharacterButton)
        
        addCharacterButton.addTarget(self, action: #selector(addCharacterToDB), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            addCharacterButton.topAnchor.constraint(equalTo: characterDescriptionStack.bottomAnchor, constant: 20),
            addCharacterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addCharacterButton.widthAnchor.constraint(equalToConstant: 200),
            addCharacterButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc private func addCharacterToDB() {
        
        if let characterName = nameTextField.text, !characterName.isEmpty,
           let animeId = animeIdTextField.text, !animeId.isEmpty,
           let characterDescription = descriptionTextField.text, !characterDescription.isEmpty {
            if let animeId = Int(animeId) {
                
                guard let connection = getConnectionToDb() else { return }
                defer { connection.close() }
                
                let result = addCharacter(connection: connection, name: characterName, id: animeId, description: characterDescription)
                
                switch result {
                case .success:
                    print("Added to DB")
                    animateImage(image: successImage)
                case .failure(let error):
                    print("Not added to DB")
                    print(error)
                    animateImage(image: failImage)
                }
                
            } else {
                print("Anime ID must be int")
                animateImage(image: failImage)
            }
            
        } else {
            print("One of fields is empty")
            animateImage(image: failImage)
        }
    }
    
    private func setSuccessImage() {
        view.addSubview(successImage)
        successImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            successImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            successImage.topAnchor.constraint(equalTo: addCharacterButton.bottomAnchor, constant: 30)
        ])
    }
    
    private func setFailImage() {
        view.addSubview(failImage)
        failImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            failImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            failImage.topAnchor.constraint(equalTo: addCharacterButton.bottomAnchor, constant: 30)
        ])
    }
    
    
    private func animateImage(image: UIImageView) {
        image.alpha = 0
        image.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
         
         UIView.animate(withDuration: 0.6, delay: 0, options: [.curveEaseInOut], animations: {
             image.alpha = 1
             image.transform = .identity
         }) { _ in

             UIView.animate(withDuration: 0.6, delay: 1.5, options: [.curveEaseInOut], animations: {
                 image.alpha = 0
             }, completion: nil)
         }
     }
}


