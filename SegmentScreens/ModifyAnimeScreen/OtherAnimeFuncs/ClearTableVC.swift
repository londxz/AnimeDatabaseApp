//
//  AddGenreVC.swift
//  DatabaseAnimeApp
//
//  Created by Родион Холодов on 16.12.2024.
//

import Foundation
import UIKit

class ClearTableVC: UIViewController {
    
    let classForGetTextView = AnimeFuncsScreenController()
    
    var descriptionTextField = UITextField()
    var descriptionStack = UIStackView()
    
    override func viewDidLoad() {
        view.backgroundColor = .detailsWhite

        setBannerImage()
        setTextViews()
        setAddGenreButton()
        
        setSuccessImage()
        setFailImage()
    }
    
    lazy var button: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .detailsWhite
        btn.setTitleColor(.failPurple, for: .normal)
        btn.setTitle("о_О", for: .highlighted)
        btn.titleLabel?.font = UIFont(name: "Verdana-Bold", size: 16)
        btn.setTitle("Clear table", for: .normal)

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
        bannerImage.image = .anime2
        
        
        NSLayoutConstraint.activate([
            bannerImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bannerImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 40)
        ])
    }
    
    private func setTextViews() {
        
        descriptionStack = classForGetTextView.getTextView(textField: descriptionTextField, placeholder: "Table name to clear")
        
        view.addSubview(descriptionStack)
        
        NSLayoutConstraint.activate([
            descriptionStack.topAnchor.constraint(equalTo: bannerImage.bottomAnchor, constant: 50),
            descriptionStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20)
            
        ])
    }
    
    private func setAddGenreButton() {
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        button.addTarget(self, action: #selector(deleteCharacter), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: descriptionStack.bottomAnchor, constant: 20),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 200),
            button.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc private func deleteCharacter() {
        
        guard let connection = getConnectionToDb() else { return }
        defer { connection.close() }
        
        
        if let description = descriptionTextField.text, !description.isEmpty {
            
            let result = clearTable(connection: connection, name: description)
            
            switch result {
            case .success:
                print("Deleted")
                animateImage(image: successImage)
            case .failure(let error):
                print("Not deleted")
                print(error)
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
            successImage.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 50)
        ])
    }
    
    private func setFailImage() {
        view.addSubview(failImage)
        failImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            failImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            failImage.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 50)
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


