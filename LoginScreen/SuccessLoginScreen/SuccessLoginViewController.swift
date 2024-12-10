//
//  SuccessLogin.swift
//  DatabaseAnimeApp
//
//  Created by Родион Холодов on 07.12.2024.
//

import UIKit

class SuccessLoginViewController: UIViewController {
    
    override func viewDidLoad() {
        view.backgroundColor = .systemGray5
        setBannerImage()
        setWelcomeLabel()
        
    }
    
    lazy var successImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        
        NSLayoutConstraint.activate([
            image.widthAnchor.constraint(equalToConstant: 300),
            image.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        return image
    }()
    
    lazy var welcomeLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "Verdana-Bold", size: 23)
        
        return lbl
    }()
    
    private func setBannerImage() {
        view.addSubview(successImage)
        successImage.image = .successLogin2
        
        
        NSLayoutConstraint.activate([
            successImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            successImage.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setWelcomeLabel() {
        
        view.addSubview(welcomeLabel)
        welcomeLabel.text = "Welcome, \(UserCredentials.login)!"
        
        NSLayoutConstraint.activate([
            welcomeLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
