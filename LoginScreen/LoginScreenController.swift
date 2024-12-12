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
        
        for family: String in UIFont.familyNames {
            print(family)
            for names: String in UIFont.fontNames(forFamilyName: family) {
                print("== \(names)")
             }
        }


        guard let connection = getConnectionToDb() else { return }
        defer { connection.close() }

        guard let res = getAnimeData(connection: connection, numRows: 100) else { return }
        //print("RESULT:\n\(res)")
        //let animka = res[0]
        //let cellM = AnimeCellViewModel(anime: animka)
        //print(cellM)
        
        let testAnime = AnimeModel(
            id: 1,
            name: "Test Anime",
            studio: "Test Studio",
            synopsis: "Test Synopsis",
            image_url: "http://www.world-art.ru/animation/img/12000/11300/1.jpg",
            premiere_date: "2024-01-01",
            finale_date: "2024-12-31",
            num_episodes: 12,
            score: 8.5,
            genre: "Action",
            type: "TV",
            status: "Completed",
            updated_at: "2024-12-10"
        )
        let testViewModel = AnimeCellViewModel(anime: testAnime)
        print(testViewModel)
        
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
