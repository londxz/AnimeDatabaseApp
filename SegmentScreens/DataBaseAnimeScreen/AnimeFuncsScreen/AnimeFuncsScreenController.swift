//
//  SecondViewController.swift
//  DatabaseAnimeApp
//
//  Created by Родион Холодов on 15.12.2024.
//

import UIKit

class AnimeFuncsScreenController: UIViewController {
    
    let build = AnimeFuncsScreenView.shared
    
    var addAnimeButton = UIButton()
    var addGenreButton = UIButton()
    var addStudioButton = UIButton()
    var addAnimeNamesButton = UIButton()
    var addCharacterButton = UIButton()
    
    let buttonHeight: CGFloat = 60
    let buttonWidth: CGFloat = 200
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        setAddAnimeButton()
        setAddGenreButton()
        setAddStudioButton()
        setAddAnimeNamesButton()
        setAddCharacterButton()
    }
    
    private func setAddAnimeButton() {
        addAnimeButton = build.addAnimeButton
        addAnimeButton.translatesAutoresizingMaskIntoConstraints = false
        addAnimeButton.addTarget(self, action: #selector(pressAnime), for: .touchUpInside)
        view.addSubview(addAnimeButton)
        
        NSLayoutConstraint.activate([
            addAnimeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 110),
            addAnimeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addAnimeButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            addAnimeButton.heightAnchor.constraint(equalToConstant: buttonHeight)
        ])
    }
    
    @objc private func pressAnime() {
        print("pressAnime pressed")
        showAddAnimeScreen()
    }
    
    private func showAddAnimeScreen() {
        
        let nextViewController = AddAnimeVC()
        nextViewController.modalPresentationStyle = .pageSheet // или .automatic
 
        present(nextViewController, animated: true, completion: nil)
    }
    
    private func setAddGenreButton() {
        addGenreButton = build.addGenreButton
        addGenreButton.translatesAutoresizingMaskIntoConstraints = false
        addGenreButton.addTarget(self, action: #selector(pressGenre), for: .touchUpInside)
        view.addSubview(addGenreButton)
        
        NSLayoutConstraint.activate([
            addGenreButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addGenreButton.topAnchor.constraint(equalTo: addAnimeButton.bottomAnchor, constant: 40),
            addGenreButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            addGenreButton.heightAnchor.constraint(equalToConstant: buttonHeight)
        ])
    }
    
    @objc private func pressGenre() {
        showAddGenreScreen()
    }
    
    private func showAddGenreScreen() {
        
        let nextViewController = AddGenreVC()
        nextViewController.modalPresentationStyle = .pageSheet // или .automatic
 
        present(nextViewController, animated: true, completion: nil)
    }
    
    private func setAddStudioButton() {
        addStudioButton = build.addStudioButton
        addStudioButton.translatesAutoresizingMaskIntoConstraints = false
        addStudioButton.addTarget(self, action: #selector(pressStudio), for: .touchUpInside)
        view.addSubview(addStudioButton)
        
        NSLayoutConstraint.activate([
            addStudioButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addStudioButton.topAnchor.constraint(equalTo: addGenreButton.bottomAnchor, constant: 40),
            addStudioButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            addStudioButton.heightAnchor.constraint(equalToConstant: buttonHeight)
        ])
    }
    
    @objc private func pressStudio() {
        showAddStudioScreen()
    }
    
    private func showAddStudioScreen() {
        
        let nextViewController = AddStudioVC()
        nextViewController.modalPresentationStyle = .pageSheet // или .automatic
 
        present(nextViewController, animated: true, completion: nil)
    }
    
    private func setAddAnimeNamesButton() {
        addAnimeNamesButton = build.addAnimeNameButton
        addAnimeNamesButton.translatesAutoresizingMaskIntoConstraints = false
        addAnimeNamesButton.addTarget(self, action: #selector(pressAnimeNames), for: .touchUpInside)
        view.addSubview(addAnimeNamesButton)
        
        NSLayoutConstraint.activate([
            addAnimeNamesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addAnimeNamesButton.topAnchor.constraint(equalTo: addStudioButton.bottomAnchor, constant: 40),
            addAnimeNamesButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            addAnimeNamesButton.heightAnchor.constraint(equalToConstant: buttonHeight)
        ])
    }
    
    @objc private func pressAnimeNames() {
        showAddAnimeNamesScreen()
    }
    
    private func showAddAnimeNamesScreen() {
        
        let nextViewController = AddAnimeNamesVC()
        nextViewController.modalPresentationStyle = .pageSheet // или .automatic
 
        present(nextViewController, animated: true, completion: nil)
    }
    
    private func setAddCharacterButton() {
        addCharacterButton = build.addCharacterButton
        addCharacterButton.translatesAutoresizingMaskIntoConstraints = false
        addCharacterButton.addTarget(self, action: #selector(pressCharacter), for: .touchUpInside)
        view.addSubview(addCharacterButton)
        
        NSLayoutConstraint.activate([
            addCharacterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addCharacterButton.topAnchor.constraint(equalTo: addAnimeNamesButton.bottomAnchor, constant: 40),
            addCharacterButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            addCharacterButton.heightAnchor.constraint(equalToConstant: buttonHeight)
        ])
    }
    
    @objc private func pressCharacter() {
        showAddCharacterScreen()
    }
    
    private func showAddCharacterScreen() {
        
        let nextViewController = AddCharacterVC()
        nextViewController.modalPresentationStyle = .pageSheet // или .automatic
 
        present(nextViewController, animated: true, completion: nil)
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
            textField.placeholder = "Enter \(placeholder.lowercased())"
            
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
