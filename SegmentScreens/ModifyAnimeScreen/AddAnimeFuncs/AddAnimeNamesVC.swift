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
    var japanTextField = UITextField()
    var romajiTextField = UITextField()
    var romajiStack = UIStackView()
    
    override func viewDidLoad() {
        view.backgroundColor = .detailsWhite

        setBannerImage()
        setTextViews()
        
        setAddAnimeNameButton()
        
        setSuccessImage()
        setFailImage()
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
        bannerImage.image = .anime3
        
        
        NSLayoutConstraint.activate([
            bannerImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bannerImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 50)
        ])
    }
    
    private func setTextViews() {
        let idStack = classForGetTextView.getTextView(textField: nameTextField, placeholder: "Anime id")
        let japanStack = classForGetTextView.getTextView(textField: japanTextField, placeholder: "Japanese name")
        romajiStack = classForGetTextView.getTextView(textField: romajiTextField, placeholder: "Romaji name")
        
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
            romajiStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20)
            
        ])
    }
    
    private func setAddAnimeNameButton() {
        addAnimeNameButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addAnimeNameButton)
        
        addAnimeNameButton.addTarget(self, action: #selector(addAnimeNameToDB), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            addAnimeNameButton.topAnchor.constraint(equalTo: romajiStack.bottomAnchor, constant: 20),
            addAnimeNameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addAnimeNameButton.widthAnchor.constraint(equalToConstant: 200),
            addAnimeNameButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc private func addAnimeNameToDB() {
        
        if let animeIdText = nameTextField.text, !animeIdText.isEmpty,
           let japanName = japanTextField.text, !japanName.isEmpty,
           let romajiName = romajiTextField.text, !romajiName.isEmpty {
            
            if let animeId = Int(animeIdText) {
                
                guard let connection = getConnectionToDb() else { return }
                defer { connection.close() }
                
                let result = addAnimeNameLocale(connection: connection, id: animeId, japaneseName: japanName, romajiName: romajiName)
                
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
            print("One of the fields is empty")
            animateImage(image: failImage)
        }
    }
    
    private func setSuccessImage() {
        view.addSubview(successImage)
        successImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            successImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            successImage.topAnchor.constraint(equalTo: addAnimeNameButton.bottomAnchor, constant: 30)
        ])
    }
    
    private func setFailImage() {
        view.addSubview(failImage)
        failImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            failImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            failImage.topAnchor.constraint(equalTo: addAnimeNameButton.bottomAnchor, constant: 30)
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

