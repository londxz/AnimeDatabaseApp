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
    var studioDescriptionStack = UIStackView()
    
    override func viewDidLoad() {
        view.backgroundColor = .detailsWhite

        setBannerImage()
        setTextViews()
        setAddStudioButton()
        
        setSuccessImage()
        setFailImage()
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
        bannerImage.image = .anime1
        
        
        NSLayoutConstraint.activate([
            bannerImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bannerImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 50)
        ])
    }
    
    private func setTextViews() {
        let nameStack = classForGetTextView.getTextView(textField: nameTextField, placeholder: "Studio")
        studioDescriptionStack = classForGetTextView.getTextView(textField: descriptionTextField, placeholder: "Studio description")
        
        view.addSubview(nameStack)
        view.addSubview(studioDescriptionStack)
        
        NSLayoutConstraint.activate([
            nameStack.topAnchor.constraint(equalTo: bannerImage.bottomAnchor, constant: 30),
            nameStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            
            studioDescriptionStack.topAnchor.constraint(equalTo: nameStack.bottomAnchor, constant: 10),
            studioDescriptionStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            studioDescriptionStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20)
            
        ])
    }
    
    private func setAddStudioButton() {
        addStudioButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addStudioButton)
        
        addStudioButton.addTarget(self, action: #selector(addStudioToDB), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            addStudioButton.topAnchor.constraint(equalTo: studioDescriptionStack.bottomAnchor, constant: 20),
            addStudioButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addStudioButton.widthAnchor.constraint(equalToConstant: 200),
            addStudioButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc private func addStudioToDB() {
        
        guard let connection = getConnectionToDb() else { return }
        defer { connection.close() }
        
        
        if let studioName = nameTextField.text, !studioName.isEmpty,
           let studioDescription = descriptionTextField.text, !studioDescription.isEmpty {
            addStudio(connection: connection, name: studioName, description: studioDescription)
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
            successImage.topAnchor.constraint(equalTo: addStudioButton.bottomAnchor, constant: 50)
        ])
    }
    
    private func setFailImage() {
        view.addSubview(failImage)
        failImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            failImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            failImage.topAnchor.constraint(equalTo: addStudioButton.bottomAnchor, constant: 50)
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
