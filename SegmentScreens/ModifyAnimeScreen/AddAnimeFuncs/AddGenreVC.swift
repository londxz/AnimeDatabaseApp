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
    var genreDescriptionStack = UIStackView()
    
    override func viewDidLoad() {
        view.backgroundColor = .detailsWhite

        setBannerImage()
        setTextViews()
        setAddGenreButton()
        
        setSuccessImage()
        setFailImage()
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
        bannerImage.image = .welcomeIcon
        
        
        NSLayoutConstraint.activate([
            bannerImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bannerImage.topAnchor.constraint(equalTo: view.topAnchor)
        ])
    }
    
    private func setTextViews() {
        let nameStack = classForGetTextView.getTextView(textField: nameTextField, placeholder: "Genre")
        genreDescriptionStack = classForGetTextView.getTextView(textField: descriptionTextField, placeholder: "Genre description")
        
        
        view.addSubview(nameStack)
        view.addSubview(genreDescriptionStack)
        
        NSLayoutConstraint.activate([
            nameStack.topAnchor.constraint(equalTo: bannerImage.bottomAnchor, constant: 10),
            nameStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            
            genreDescriptionStack.topAnchor.constraint(equalTo: nameStack.bottomAnchor, constant: 10),
            genreDescriptionStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            genreDescriptionStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            
        ])
    }
    
    private func setAddGenreButton() {
        addGenreButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addGenreButton)
        
        addGenreButton.addTarget(self, action: #selector(addGenreToDB), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            addGenreButton.topAnchor.constraint(equalTo: genreDescriptionStack.bottomAnchor, constant: 20),
            addGenreButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addGenreButton.widthAnchor.constraint(equalToConstant: 200),
            addGenreButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc private func addGenreToDB() {
        
        guard let connection = getConnectionToDb() else { return }
        defer { connection.close() }
        
        
        if let genreName = nameTextField.text, !genreName.isEmpty,
           let genreDescription = descriptionTextField.text, !genreDescription.isEmpty {
            addGenre(connection: connection, name: genreName, description: genreDescription)
            animateImage(image: successImage)
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
            successImage.topAnchor.constraint(equalTo: addGenreButton.bottomAnchor, constant: 50)
        ])
    }
    
    private func setFailImage() {
        view.addSubview(failImage)
        failImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            failImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            failImage.topAnchor.constraint(equalTo: addGenreButton.bottomAnchor, constant: 50)
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
