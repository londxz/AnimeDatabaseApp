//
//  LoginScreenView.swift
//  DatabaseAnimeApp
//
//  Created by Родион Холодов on 06.12.2024.
//

import UIKit

class LoginScreenView {
    
    //make it singleton
    static let shared = LoginScreenView()
    private init() {}
    
    lazy var bannerImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            image.widthAnchor.constraint(equalToConstant: 170),
            image.heightAnchor.constraint(equalToConstant: 170)
        ])
        
        return image
    }()
    
    lazy var contentView: UIView = {
           
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 30

        return view
    }()
    
    func getTextView(textField: UITextField, placeholder: String, isPassword: Bool = false) -> UIStackView {
        
        lazy var hidePasswordButton : UIButton = {
            let button = UIButton(primaryAction: action)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setImage(UIImage(systemName: "eye.fill"), for: .normal)
            button.tintColor = .systemGray
            
            return button
        }()
        
        lazy var action = UIAction { _ in
            textField.isSecureTextEntry.toggle()
            
            if textField.isSecureTextEntry {
                hidePasswordButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
            } else {
                hidePasswordButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)

            }
        }
        
        lazy var placeholderText: UIView = {
            
            let text = UILabel()
            text.translatesAutoresizingMaskIntoConstraints = false
            text.text = placeholder
            text.font = .systemFont(ofSize: 16, weight: .regular)
            text.textColor = .black
            
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(text)
            
            text.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 19).isActive = true
            view.heightAnchor.constraint(equalToConstant: 16).isActive = true
            
            return view
        }()
        
        lazy var fieldView: UIView = {
           
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(textField)
            
            view.layer.cornerRadius = 15
            view.backgroundColor = .systemGray5

            textField.translatesAutoresizingMaskIntoConstraints = false
            textField.isSecureTextEntry = isPassword
            if isPassword {
                textField.placeholder = " * * * * * * * * * * * * *"
            } else {
                textField.placeholder = "UserWith10DatabaseScore"
            }
            
            if isPassword {
                view.addSubview(hidePasswordButton)
                
                NSLayoutConstraint.activate([
                    hidePasswordButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                    hidePasswordButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
                ])
            }
            
            textField.autocapitalizationType = .none
            
            NSLayoutConstraint.activate([
                textField.topAnchor.constraint(equalTo: view.topAnchor),
                textField.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
                view.heightAnchor.constraint(equalToConstant: 62)
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
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log in", for: .normal)
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()

    
}
