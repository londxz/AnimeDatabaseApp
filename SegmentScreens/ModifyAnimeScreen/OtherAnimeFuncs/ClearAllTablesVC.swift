//
//  AddGenreVC.swift
//  DatabaseAnimeApp
//
//  Created by Родион Холодов on 16.12.2024.
//

import Foundation
import UIKit

class ClearAllTablesVC: UIViewController {
    
    let classForGetTextView = AnimeFuncsScreenController()
    
    override func viewDidLoad() {
        view.backgroundColor = .detailsWhite

        setBannerImage()

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
        btn.setTitle("Clear all tables", for: .normal)

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
            image.widthAnchor.constraint(equalToConstant: 250),
            image.heightAnchor.constraint(equalToConstant: 250)
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
        bannerImage.image = .cryAnime
        
        
        NSLayoutConstraint.activate([
            bannerImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            bannerImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 50)
        ])
    }
    
    
    private func setAddGenreButton() {
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        button.addTarget(self, action: #selector(deleteCharacter), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 200),
            button.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc private func deleteCharacter() {
        
        guard let connection = getConnectionToDb() else { return }
        defer { connection.close() }
        
        let result = clearAllTables(connection: connection)
        
        switch result {
        case .success:
            print("Deleted")
            animateImage(image: successImage)
        case .failure(let error):
            print("Not deleted")
            print(error)
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


