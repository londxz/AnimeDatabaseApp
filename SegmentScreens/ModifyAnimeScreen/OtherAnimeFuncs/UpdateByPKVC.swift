//
//  AddGenreVC.swift
//  DatabaseAnimeApp
//
//  Created by Родион Холодов on 16.12.2024.
//

import Foundation
import UIKit

class UpdateByPKVC: UIViewController {
    
    let classForGetTextView = AnimeFuncsScreenController()
    
    var tableNameTextField = UITextField()
    var pkColTextField = UITextField()
    var pkValueTextField = UITextField()
    var fieldToUpdateTextField = UITextField()
    var valueToUpdateTextField = UITextField()
    var valueToUpdateStack = UIStackView()
    
    override func viewDidLoad() {
        view.backgroundColor = .detailsWhite

        setBannerImage()
        setTextViews()
        
        setAddCharacterButton()
        
        setSuccessImage()
        setFailImage()
    }
    
    lazy var button: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .detailsWhite
        btn.setTitleColor(.failPurple, for: .normal)
        btn.setTitle("о_О", for: .highlighted)
        btn.titleLabel?.font = UIFont(name: "Verdana-Bold", size: 16)
        btn.setTitle("Update", for: .normal)

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
            image.widthAnchor.constraint(equalToConstant: 150),
            image.heightAnchor.constraint(equalToConstant: 150)
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
            image.widthAnchor.constraint(equalToConstant: 100),
            image.heightAnchor.constraint(equalToConstant: 100)
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
            image.widthAnchor.constraint(equalToConstant: 100),
            image.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        return image
    }()
    
    private func setBannerImage() {
        view.addSubview(bannerImage)
        bannerImage.image = .anime4
        
        
        NSLayoutConstraint.activate([
            bannerImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bannerImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 50)
        ])
    }
    
    private func setTextViews() {
        let tableName = classForGetTextView.getTextView(textField: tableNameTextField, placeholder: "Table to update")
        let pkName = classForGetTextView.getTextView(textField: pkColTextField, placeholder: "Name of primary key")
        let pkValue = classForGetTextView.getTextView(textField: pkValueTextField, placeholder: "Value of primary key")
        let fieldToUpdate = classForGetTextView.getTextView(textField: fieldToUpdateTextField, placeholder: "Field to update")
        
        valueToUpdateStack = classForGetTextView.getTextView(textField: valueToUpdateTextField, placeholder: "Changed value")
        
        
        view.addSubview(tableName)
        view.addSubview(pkName)
        view.addSubview(pkValue)
        view.addSubview(fieldToUpdate)
        view.addSubview(valueToUpdateStack)
        
        NSLayoutConstraint.activate([
            
            tableName.topAnchor.constraint(equalTo: bannerImage.bottomAnchor, constant: 20),
            tableName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableName.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            
            pkName.topAnchor.constraint(equalTo: tableName.bottomAnchor, constant: 10),
            pkName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            pkName.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            
            pkValue.topAnchor.constraint(equalTo: pkName.bottomAnchor, constant: 10),
            pkValue.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            pkValue.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            
            fieldToUpdate.topAnchor.constraint(equalTo: pkValue.bottomAnchor, constant: 10),
            fieldToUpdate.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            fieldToUpdate.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            
            valueToUpdateStack.topAnchor.constraint(equalTo: fieldToUpdate.bottomAnchor, constant: 10),
            valueToUpdateStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            valueToUpdateStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            
        ])
    }
    
    private func setAddCharacterButton() {
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        button.addTarget(self, action: #selector(addCharacterToDB), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: valueToUpdateStack.bottomAnchor, constant: 20),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 200),
            button.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc private func addCharacterToDB() {
        
        if let tableName = tableNameTextField.text, !tableName.isEmpty,
           let pkCol = pkColTextField.text, !pkCol.isEmpty,
           let pkValue = pkValueTextField.text, !pkValue.isEmpty,
           let fieldToUpdate = fieldToUpdateTextField.text, !fieldToUpdate.isEmpty,
           let valueToUpdate = valueToUpdateTextField.text, !valueToUpdate.isEmpty {
            
                guard let connection = getConnectionToDb() else { return }
                defer { connection.close() }
                
            let result = updateByPrimaryKey(connection: connection, tableName: tableName, primaryKeyColumn: pkCol, primaryKeyValue: pkValue, updates: [fieldToUpdate: valueToUpdate])
                
                switch result {
                case .success:
                    print("Updated")
                    animateImage(image: successImage)
                case .failure(let error):
                    print("Not updated")
                    print(error)
                    animateImage(image: failImage)
                }
            
        } else {
            print("One of fields is empty")
            animateImage(image: failImage)
        }
    }
    
    private func setSuccessImage() {
        view.addSubview(successImage)
        successImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            successImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            successImage.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 20)
        ])
    }
    
    private func setFailImage() {
        view.addSubview(failImage)
        failImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            failImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            failImage.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 20)
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



