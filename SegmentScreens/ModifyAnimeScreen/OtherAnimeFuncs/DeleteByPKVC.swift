//
//  AddGenreVC.swift
//  DatabaseAnimeApp
//
//  Created by Родион Холодов on 16.12.2024.
//

import Foundation
import UIKit

class DeleteByPKVC: UIViewController {
    
    let classForGetTextView = AnimeFuncsScreenController()
    
    var tableTextField = UITextField()
    var pkTextField = UITextField()
    var valueTextField = UITextField()
    var valueStack = UIStackView()
    
    override func viewDidLoad() {
        view.backgroundColor = .detailsWhite

        setBannerImage()
        setTextViews()
        
        setAddAnimeNameButton()
        
        setSuccessImage()
        setFailImage()
    }
    
    lazy var button: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .detailsWhite
        btn.setTitleColor(.failPurple, for: .normal)
        btn.setTitle("о_О", for: .highlighted)
        btn.titleLabel?.font = UIFont(name: "Verdana-Bold", size: 16)
        btn.setTitle("Delete table", for: .normal)

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
        bannerImage.image = .anime3
        
        
        NSLayoutConstraint.activate([
            bannerImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bannerImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 50)
        ])
    }
    
    private func setTextViews() {
        let tableStack = classForGetTextView.getTextView(textField: tableTextField, placeholder: "Table name")
        let pkStack = classForGetTextView.getTextView(textField: pkTextField, placeholder: "Table primary key")
        valueStack = classForGetTextView.getTextView(textField: valueTextField, placeholder: "Value of primary key")
        
        view.addSubview(tableStack)
        view.addSubview(pkStack)
        view.addSubview(valueStack)
        
        NSLayoutConstraint.activate([
            tableStack.topAnchor.constraint(equalTo: bannerImage.bottomAnchor, constant: 20),
            tableStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            
            pkStack.topAnchor.constraint(equalTo: tableStack.bottomAnchor, constant: 10),
            pkStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            pkStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            
            valueStack.topAnchor.constraint(equalTo: pkStack.bottomAnchor, constant: 10),
            valueStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            valueStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20)
            
        ])
    }
    
    private func setAddAnimeNameButton() {
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        button.addTarget(self, action: #selector(addAnimeNameToDB), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: valueStack.bottomAnchor, constant: 20),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 200),
            button.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc private func addAnimeNameToDB() {
        
        if let table = tableTextField.text, !table.isEmpty,
           let pk = pkTextField.text, !pk.isEmpty,
           let value = valueTextField.text, !value.isEmpty {
 
            guard let connection = getConnectionToDb() else { return }
            defer { connection.close() }
            
            let result = deleteByPk(connection: connection, name: table, pkColumn: pk, pkValue: value)
            
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
            successImage.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 30)
        ])
    }
    
    private func setFailImage() {
        view.addSubview(failImage)
        failImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            failImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            failImage.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 30)
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


