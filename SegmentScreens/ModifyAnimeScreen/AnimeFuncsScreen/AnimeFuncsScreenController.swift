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
    
    var deleteByPKButton = UIButton()
    var deleteCharacterButton = UIButton()
    var clearTableButton = UIButton()
    var clearAllTablesButton = UIButton()
    var updateByPKButton = UIButton()
    
    let buttonHeight: CGFloat = 60
    let buttonWidth: CGFloat = 165
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        setAddAnimeButton()
        setAddGenreButton()
        setAddStudioButton()
        setAddAnimeNamesButton()
        setAddCharacterButton()
        
        setDeleteByPKButton()
        setDeleteCharacterButton()
        setClearTableButton()
        setClearAllTablesButton()
        setUpdateByPKButton()
    }
    
    private func setAddAnimeButton() {
        addAnimeButton = build.addAnimeButton
        addAnimeButton.translatesAutoresizingMaskIntoConstraints = false
        addAnimeButton.addTarget(self, action: #selector(pressAnime), for: .touchUpInside)
        view.addSubview(addAnimeButton)
        
        NSLayoutConstraint.activate([
            addAnimeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 110),
            addAnimeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
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
    
    private func setDeleteByPKButton() {
        deleteByPKButton = build.deleteByPKButton
        deleteByPKButton.translatesAutoresizingMaskIntoConstraints = false
        deleteByPKButton.addTarget(self, action: #selector(pressDeleteByPK), for: .touchUpInside)
        view.addSubview(deleteByPKButton)
        
        NSLayoutConstraint.activate([
            deleteByPKButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 110),
            deleteByPKButton.bottomAnchor.constraint(equalTo: addAnimeButton.bottomAnchor),
            deleteByPKButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            deleteByPKButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            deleteByPKButton.heightAnchor.constraint(equalToConstant: buttonHeight)
        ])
    }
    
    @objc private func pressDeleteByPK() {
        print("pressDeleteByPK pressed")
        showDeleteByPKScreen()
    }
    
    private func showDeleteByPKScreen() {
        
        let nextViewController = DeleteByPKVC()
        nextViewController.modalPresentationStyle = .pageSheet // или .automatic
 
        present(nextViewController, animated: true, completion: nil)
    }
    
    private func setAddGenreButton() {
        addGenreButton = build.addGenreButton
        addGenreButton.translatesAutoresizingMaskIntoConstraints = false
        addGenreButton.addTarget(self, action: #selector(pressGenre), for: .touchUpInside)
        view.addSubview(addGenreButton)
        
        NSLayoutConstraint.activate([
            addGenreButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
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
    
    private func setDeleteCharacterButton() {
        deleteCharacterButton = build.deleteCharacterButton
        deleteCharacterButton.translatesAutoresizingMaskIntoConstraints = false
        deleteCharacterButton.addTarget(self, action: #selector(pressDeleteCharacter), for: .touchUpInside)
        view.addSubview(deleteCharacterButton)
        
        NSLayoutConstraint.activate([
            deleteCharacterButton.bottomAnchor.constraint(equalTo: addGenreButton.bottomAnchor),
            deleteCharacterButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            deleteCharacterButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            deleteCharacterButton.heightAnchor.constraint(equalToConstant: buttonHeight)
        ])
    }
    
    @objc private func pressDeleteCharacter() {
        print("pressDeleteCharacter pressed")
        showDeleteCharacterButtonScreen()
    }
    
    private func showDeleteCharacterButtonScreen() {
        
        let nextViewController = DeleteCharacterVC()
        nextViewController.modalPresentationStyle = .pageSheet // или .automatic
 
        present(nextViewController, animated: true, completion: nil)
    }
    
    private func setAddStudioButton() {
        addStudioButton = build.addStudioButton
        addStudioButton.translatesAutoresizingMaskIntoConstraints = false
        addStudioButton.addTarget(self, action: #selector(pressStudio), for: .touchUpInside)
        view.addSubview(addStudioButton)
        
        NSLayoutConstraint.activate([
            addStudioButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
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
    
    private func setClearTableButton() {
        clearTableButton = build.clearTableButton
        clearTableButton.translatesAutoresizingMaskIntoConstraints = false
        clearTableButton.addTarget(self, action: #selector(pressClearTableButton), for: .touchUpInside)
        view.addSubview(clearTableButton)
        
        NSLayoutConstraint.activate([
            clearTableButton.bottomAnchor.constraint(equalTo: addStudioButton.bottomAnchor),
            clearTableButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            clearTableButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            clearTableButton.heightAnchor.constraint(equalToConstant: buttonHeight)
        ])
    }
    
    @objc private func pressClearTableButton() {
        print("pressClearTableButton pressed")
        showClearTableButtonScreen()
    }
    
    private func showClearTableButtonScreen() {
        
        let nextViewController = ClearTableVC()
        nextViewController.modalPresentationStyle = .pageSheet // или .automatic
 
        present(nextViewController, animated: true, completion: nil)
    }
    
    private func setAddAnimeNamesButton() {
        addAnimeNamesButton = build.addAnimeNameButton
        addAnimeNamesButton.translatesAutoresizingMaskIntoConstraints = false
        addAnimeNamesButton.addTarget(self, action: #selector(pressAnimeNames), for: .touchUpInside)
        view.addSubview(addAnimeNamesButton)
        
        NSLayoutConstraint.activate([
            addAnimeNamesButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
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
    
    private func setClearAllTablesButton() {
        clearAllTablesButton = build.clearAllTablesButton
        clearAllTablesButton.translatesAutoresizingMaskIntoConstraints = false
        clearAllTablesButton.addTarget(self, action: #selector(presssedClearAllTablesButton), for: .touchUpInside)
        view.addSubview(clearAllTablesButton)
        
        NSLayoutConstraint.activate([
            clearAllTablesButton.bottomAnchor.constraint(equalTo: addAnimeNamesButton.bottomAnchor),
            clearAllTablesButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            clearAllTablesButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            clearAllTablesButton.heightAnchor.constraint(equalToConstant: buttonHeight)
        ])
    }
    
    @objc private func presssedClearAllTablesButton() {
        print("presssedClearAllTablesButton pressed")
        showClearAllTablesButton()
    }
    
    private func showClearAllTablesButton() {
        
        let nextViewController = ClearAllTablesVC()
        nextViewController.modalPresentationStyle = .pageSheet // или .automatic
 
        present(nextViewController, animated: true, completion: nil)
    }
    
    private func setAddCharacterButton() {
        addCharacterButton = build.addCharacterButton
        addCharacterButton.translatesAutoresizingMaskIntoConstraints = false
        addCharacterButton.addTarget(self, action: #selector(pressCharacter), for: .touchUpInside)
        view.addSubview(addCharacterButton)
        
        NSLayoutConstraint.activate([
            addCharacterButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
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
    
    private func setUpdateByPKButton() {
        updateByPKButton = build.updateByPKButton
        updateByPKButton.translatesAutoresizingMaskIntoConstraints = false
        updateByPKButton.addTarget(self, action: #selector(presssedUpdateByPKButton), for: .touchUpInside)
        view.addSubview(updateByPKButton)
        
        NSLayoutConstraint.activate([
            updateByPKButton.bottomAnchor.constraint(equalTo: addCharacterButton.bottomAnchor),
            updateByPKButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            updateByPKButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            updateByPKButton.heightAnchor.constraint(equalToConstant: buttonHeight)
        ])
    }
    
    @objc private func presssedUpdateByPKButton() {
        print("presssedUpdateByPKButton pressed")
        showUpdateByPKButton()
    }
    
    private func showUpdateByPKButton() {
        
        let nextViewController = UpdateByPKVC()
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
