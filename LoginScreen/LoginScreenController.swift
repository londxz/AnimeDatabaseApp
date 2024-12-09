//
//  LoginScreenController.swift
//  DatabaseAnimeApp
//
//  Created by Родион Холодов on 06.12.2024.
//

import UIKit
import PostgresClientKit

class LoginScreenController: UIViewController {
    
    private let config = PostgresConfig.shared
    
    //for ids tracking
    var ids = Id.shared
    
    private let build = LoginScreenView.shared
    private var bannerImage = UIImageView()
    private var contentView = UIView()
    private var emailTextField = UITextField()
    private var passwordTextField = UITextField()
    private var passwordStack = UIStackView()
    private var loginButton = UIButton()
    
    override func viewDidLoad() {
        view.backgroundColor = .systemGray5

        guard let connection = getConnectionToDb() else { return }
        defer { connection.close() }
        for family: String in UIFont.familyNames {
            print(family)
            for names: String in UIFont.fontNames(forFamilyName: family) {
                print("== \(names)")
             }
        }

        //getAllTablesData(connection: connection)
        //anyTextQuery(connection: connection, query: "select * from anime;")
        //addStudio(connection: connection, name: "studio add", description: "1 desc")
        //addAnime(connection: connection, name: "2Attack on Titan", studio: "Wit Studio", synopsis: "Humans fight titans", premierDate: "2013-04-07", genre: "Action", type: AnimeType.tv, status: .finished, imageUrl: "http://example.com/aot.jpg", finalDate: "2013-08-07", numEpisodes: 25, score: 10)
        //addAnimeNameLocale(connection: connection, id: 2, japaneseName: "2進撃の巨人", romajiName: "2Shingeki no Kyojin")
        //addCharacter(connection: connection, name: "2Test_Char_Name", id: 2, description: "2some_desc")
        //updateByPrimaryKey(connection: connection, tableName: "anime", primaryKeyColumn: "id", primaryKeyValue: "2", updates: ["name": "ATAKA", "score": "10"])
        //searchAnimeByEnglishName(connection: connection, englishName: "ataka")
        //deleteByPk(connection: connection, name: "anime", pkColumn: "id", pkValue: "1")
        //deleteCharacterByDescription(connection: connection, description: "some_desc")
        //clearAllTables(connection: connection)
        
        //getGenreData(connection: connection, numRows: 3)
        //getStudioData(connection: connection, numRows: 3)
        //getAnimeData(connection: connection, numRows: 3)
        //getAnimeNameLocaleData(connection: connection, numRows: 3)
        getCharacterData(connection: connection, numRows: 3)
        
        setBannerImage()
        setContentView()
        setEmailTextView()
        setLoginButton()
    }
    
    private func setBannerImage() {
        bannerImage = build.bannerImage
        view.addSubview(bannerImage)
        bannerImage.image = .welcome2
        bannerImage.contentMode = .scaleAspectFill
        
        NSLayoutConstraint.activate([
            bannerImage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            bannerImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
    }
    
    private func setContentView() {
        contentView = build.contentView
        view.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -170),
            contentView.leftAnchor.constraint(equalTo: view.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: view.rightAnchor)
            , contentView.topAnchor.constraint(equalTo: bannerImage.bottomAnchor, constant: 30)
        ])
    }
    
    private func setEmailTextView() {
        
        let emailStack = build.getTextView(textField: emailTextField, placeholder: "Login")
        
        passwordStack = build.getTextView(textField: passwordTextField, placeholder: "Password", isPassword: true)
        
        view.addSubview(emailStack)
        view.addSubview(passwordStack)
        
        NSLayoutConstraint.activate([
            emailStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            emailStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            emailStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20),
            
            passwordStack.topAnchor.constraint(equalTo: emailStack.bottomAnchor, constant: 30),
            passwordStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            passwordStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20)
        ])
        
    }
    
    private func setLoginButton() {
        loginButton = build.loginButton
        contentView.addSubview(loginButton)
        
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 50),
            loginButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: 62)
        ])
    }
    
    //MARK:- navigation funcs
    private func showLoginErrorScreen(error: String) {
        
        let nextViewController = FailLoginViewController(text: error)
        nextViewController.modalPresentationStyle = .pageSheet // или .automatic
 
        present(nextViewController, animated: true, completion: nil)
    }
    
    private func showSuccesScreenAndGoToMain() {
        let successVC = SuccessLoginViewController()
        successVC.modalPresentationStyle = .fullScreen
        
        // Заменяем корневой контроллер на tempVC
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        
        if let window = windowScene?.windows.first {
                // Анимация перехода к successVC
            UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromRight, animations: {
                    window.rootViewController = successVC
                }) { _ in
                    // После задержки выполняем переход на finalVC
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        UIView.transition(with: window, duration: 0.5, options: .transitionCurlDown, animations: {
                            let finalVC = DataBaseAnimeController()
                            window.rootViewController = finalVC
                        })
                    }
                }
            }

    }
    
    
    
    //MARK:- objc funcs
    @objc func loginButtonTapped() {
        
        guard let login = emailTextField.text, !login.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {

            showLoginErrorScreen(error: "Enter all credentials!")
            
            return
        }

        if login == UserCredentials.login, password == UserCredentials.password {
            print("Успешный вход: \(login), \(password)")
            showSuccesScreenAndGoToMain()

        } else {
            
            showLoginErrorScreen(error: "Invalid login or password!")
        }
    }
        
}
