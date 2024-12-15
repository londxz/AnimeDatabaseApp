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
        showAddGenreScreen(error: "asdasda")
    }
    
    private func showAddGenreScreen(error: String) {
        
        let nextViewController = FailLoginViewController(text: error)
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
        showAddStudioScreen(error: "You want to add studio!!")
    }
    
    private func showAddStudioScreen(error: String) {
        
        let nextViewController = FailLoginViewController(text: error)
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
        showAddStudioScreen(error: "You want to add anime names!!")
    }
    
    private func showAddAnimeNamesScreen(error: String) {
        
        let nextViewController = FailLoginViewController(text: error)
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
        showAddStudioScreen(error: "You want to add character!!")
    }
    
    private func showAddCharacterScreen(error: String) {
        
        let nextViewController = FailLoginViewController(text: error)
        nextViewController.modalPresentationStyle = .pageSheet // или .automatic
 
        present(nextViewController, animated: true, completion: nil)
    }
}
