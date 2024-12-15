//
//  AddAnimeVC.swift
//  DatabaseAnimeApp
//
//  Created by Родион Холодов on 15.12.2024.
//

import Foundation
import UIKit

class AddAnimeVC: UIViewController {
    
    var nameTextField = UITextField()
    var studioTextField = UITextField()
    var synopsisTextField = UITextField()
    var imageUrlTextField = UITextField()
    var premiereTextField = UITextField()
    var finalTextField = UITextField()
    var numEpisodesTextField = UITextField()
    var scoreTextField = UITextField()
    var genreTextField = UITextField()
    var typeTextField = UITextField()
    var statusTextField = UITextField()
    
    var fieldsStack = UIStackView()
    
    override func viewDidLoad() {
        view.backgroundColor = .detailsWhite

        //setBannerImage()
        setEmailTextView()


    }
    
    lazy var addAnimeButton: UIButton = {
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
            image.widthAnchor.constraint(equalToConstant: 200),
            image.heightAnchor.constraint(equalToConstant: 200)
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
    
    
    
    private func setEmailTextView() {
        
        let nameStack = getTextView(textField: nameTextField, placeholder: "Name")
        let synopsisStack = getTextView(textField: synopsisTextField, placeholder: "Synopsis")
        let studioStack = getTextView(textField: studioTextField, placeholder: "Studio")
        let genreStack = getTextView(textField: genreTextField, placeholder: "Genre")
        let typeStack = getTextView(textField: typeTextField, placeholder: "Type")
        let numEpisodesStack = getTextView(textField: numEpisodesTextField, placeholder: "Episodes number")
        let scoreStack = getTextView(textField: scoreTextField, placeholder: "Score")
        let statusStack = getTextView(textField: statusTextField, placeholder: "Status")
        let premiereStack = getTextView(textField: premiereTextField, placeholder: "Premiere date")
        let finalStack = getTextView(textField: finalTextField, placeholder: "Final date")
        let imageUrlStack = getTextView(textField: imageUrlTextField, placeholder: "Image URL")
        
        addAnimeButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addAnimeButton)
        
        view.addSubview(nameStack)
        view.addSubview(synopsisStack)
        view.addSubview(studioStack)
        view.addSubview(genreStack)
        view.addSubview(typeStack)
        view.addSubview(numEpisodesStack)
        view.addSubview(scoreStack)
        view.addSubview(statusStack)
        view.addSubview(premiereStack)
        view.addSubview(finalStack)
        view.addSubview(imageUrlStack)


        
        NSLayoutConstraint.activate([
            nameStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            nameStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            
            synopsisStack.topAnchor.constraint(equalTo: nameStack.bottomAnchor, constant: 10),
            synopsisStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            synopsisStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            
            studioStack.topAnchor.constraint(equalTo: synopsisStack.bottomAnchor, constant: 10),
            studioStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            studioStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            
            genreStack.topAnchor.constraint(equalTo: studioStack.bottomAnchor, constant: 10),
            genreStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            genreStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            
            typeStack.topAnchor.constraint(equalTo: genreStack.bottomAnchor, constant: 10),
            typeStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            typeStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            
            numEpisodesStack.topAnchor.constraint(equalTo: typeStack.bottomAnchor, constant: 10),
            numEpisodesStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            numEpisodesStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            
            scoreStack.topAnchor.constraint(equalTo: numEpisodesStack.bottomAnchor, constant: 10),
            scoreStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scoreStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            
            statusStack.topAnchor.constraint(equalTo: scoreStack.bottomAnchor, constant: 10),
            statusStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            statusStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            
            premiereStack.topAnchor.constraint(equalTo: statusStack.bottomAnchor, constant: 10),
            premiereStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            premiereStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            
            finalStack.topAnchor.constraint(equalTo: premiereStack.bottomAnchor, constant: 10),
            finalStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            finalStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            
            imageUrlStack.topAnchor.constraint(equalTo: finalStack.bottomAnchor, constant: 10),
            imageUrlStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            imageUrlStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
        ])
        
        NSLayoutConstraint.activate([
            addAnimeButton.topAnchor.constraint(equalTo: imageUrlStack.bottomAnchor, constant: 10),
            addAnimeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            addAnimeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addAnimeButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func getTextView(textField: UITextField, placeholder: String, isPassword: Bool = false) -> UIStackView {
        
        lazy var placeholderText: UIView = {
            
            let text = UILabel()
            text.translatesAutoresizingMaskIntoConstraints = false
            text.text = placeholder
            text.textColor = .black
            text.font = UIFont(name: "Verdana-Bold", size: 17)
            
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(text)
            
            text.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 19).isActive = true
            view.heightAnchor.constraint(equalToConstant: 14).isActive = true
            
            return view
        }()
        
        lazy var fieldView: UIView = {
           
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(textField)
            
            view.layer.cornerRadius = 15
            view.backgroundColor = .systemGray5

            textField.translatesAutoresizingMaskIntoConstraints = false
            textField.isSecureTextEntry = false
            textField.placeholder = "UserWith10DatabaseScore"
            
            textField.autocapitalizationType = .none
            
            NSLayoutConstraint.activate([
                textField.topAnchor.constraint(equalTo: view.topAnchor),
                textField.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
                view.heightAnchor.constraint(equalToConstant: 30)
            ])
            
            return view
        }()
        
        lazy var vStack: UIStackView = {
            
            let stack = UIStackView()
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.axis = .vertical
            stack.spacing = 10
            
            stack.addArrangedSubview(placeholderText)
            stack.addArrangedSubview(fieldView)
            
            return stack
        }()
        
        return vStack
    }
}
