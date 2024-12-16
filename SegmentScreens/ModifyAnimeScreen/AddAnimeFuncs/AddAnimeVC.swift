//
//  AddAnimeVC.swift
//  DatabaseAnimeApp
//
//  Created by Родион Холодов on 15.12.2024.
//

import Foundation
import UIKit

class AddAnimeVC: UIViewController {
    
    let classForGetTextView = AnimeFuncsScreenController()
    
    var nameTextField = UITextField()
    var studioTextField = UITextField()
    var synopsisTextField = UITextField()
    var imageUrlTextField = UITextField()
    var premiereTextField = UITextField()
    var finalTextField = UITextField()
    var numEpisodesTextField = UITextField()
    var scoreTextField = UITextField()
    var genreTextField = UITextField()
    var typeTextField = UITextField()
    var statusTextField = UITextField()
    
    var imageUrlStack = UIStackView()
    
    override func viewDidLoad() {
        view.backgroundColor = .detailsWhite

        setTextViews()
        
        setAddAnimeButton()
        
    }
    
    lazy var addAnimeButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .detailsWhite
        btn.setTitleColor(.failPurple, for: .normal)
        btn.setTitle("о_О", for: .highlighted)
        btn.titleLabel?.font = UIFont(name: "Verdana-Bold", size: 16)
        btn.setTitle("Add anime", for: .normal)

        btn.layer.borderWidth = 2
        btn.layer.borderColor = UIColor.failPurple.cgColor
        btn.layer.cornerRadius = 12
        return btn
    }()
    
    lazy var successImage: UIImageView = {
        let image = UIImageView()
        image.image = .successLogin
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        
        NSLayoutConstraint.activate([
            image.widthAnchor.constraint(equalToConstant: 200),
            image.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        return image
    }()
    
    lazy var failImage: UIImageView = {
        let image = UIImageView()
        image.image = .failAdd
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        
        NSLayoutConstraint.activate([
            image.widthAnchor.constraint(equalToConstant: 200),
            image.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        return image
    }()
    

    private func setTextViews() {
        
        let nameStack = classForGetTextView.getTextView(textField: nameTextField, placeholder: "Anime name")
        let synopsisStack = classForGetTextView.getTextView(textField: synopsisTextField, placeholder: "Synopsis")
        let studioStack = classForGetTextView.getTextView(textField: studioTextField, placeholder: "Studio")
        let genreStack = classForGetTextView.getTextView(textField: genreTextField, placeholder: "Genre")
        let typeStack = classForGetTextView.getTextView(textField: typeTextField, placeholder: "Type")
        let numEpisodesStack = classForGetTextView.getTextView(textField: numEpisodesTextField, placeholder: "Episodes number")
        let scoreStack = classForGetTextView.getTextView(textField: scoreTextField, placeholder: "Score")
        let statusStack = classForGetTextView.getTextView(textField: statusTextField, placeholder: "Status")
        let premiereStack = classForGetTextView.getTextView(textField: premiereTextField, placeholder: "Premiere date")
        let finalStack = classForGetTextView.getTextView(textField: finalTextField, placeholder: "Final date")
        imageUrlStack = classForGetTextView.getTextView(textField: imageUrlTextField, placeholder: "Image URL")
        
        view.addSubview(nameStack)
        view.addSubview(synopsisStack)
        view.addSubview(studioStack)
        view.addSubview(genreStack)
        view.addSubview(typeStack)
        view.addSubview(numEpisodesStack)
        view.addSubview(scoreStack)
        view.addSubview(statusStack)
        view.addSubview(premiereStack)
        view.addSubview(finalStack)
        view.addSubview(imageUrlStack)

        NSLayoutConstraint.activate([
            nameStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            nameStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            
            synopsisStack.topAnchor.constraint(equalTo: nameStack.bottomAnchor, constant: 10),
            synopsisStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            synopsisStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            
            studioStack.topAnchor.constraint(equalTo: synopsisStack.bottomAnchor, constant: 10),
            studioStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            studioStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            
            genreStack.topAnchor.constraint(equalTo: studioStack.bottomAnchor, constant: 10),
            genreStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            genreStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            
            typeStack.topAnchor.constraint(equalTo: genreStack.bottomAnchor, constant: 10),
            typeStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            typeStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            
            numEpisodesStack.topAnchor.constraint(equalTo: typeStack.bottomAnchor, constant: 10),
            numEpisodesStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            numEpisodesStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            
            scoreStack.topAnchor.constraint(equalTo: numEpisodesStack.bottomAnchor, constant: 10),
            scoreStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scoreStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            
            statusStack.topAnchor.constraint(equalTo: scoreStack.bottomAnchor, constant: 10),
            statusStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            statusStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            
            premiereStack.topAnchor.constraint(equalTo: statusStack.bottomAnchor, constant: 10),
            premiereStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            premiereStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            
            finalStack.topAnchor.constraint(equalTo: premiereStack.bottomAnchor, constant: 10),
            finalStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            finalStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            
            imageUrlStack.topAnchor.constraint(equalTo: finalStack.bottomAnchor, constant: 10),
            imageUrlStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            imageUrlStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
        ])
        
    }
    
    private func setAddAnimeButton() {
        addAnimeButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addAnimeButton)
        
        addAnimeButton.addTarget(self, action: #selector(addAnimeToDB), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            addAnimeButton.topAnchor.constraint(equalTo: imageUrlStack.bottomAnchor, constant: 10),
            addAnimeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            addAnimeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addAnimeButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    @objc private func addAnimeToDB() {
        
        guard let connection = getConnectionToDb() else { return }
        defer { connection.close() }
        
        if let animeName = nameTextField.text, !animeName.isEmpty,
           let studioName = studioTextField.text, !studioName.isEmpty,
           let synopsis = synopsisTextField.text, !synopsis.isEmpty,
           let imageUrl = imageUrlTextField.text, !imageUrl.isEmpty,
           let premiereDate = premiereTextField.text, !premiereDate.isEmpty,
           let finalDate = finalTextField.text, !finalDate.isEmpty,
           let numEpisodes = numEpisodesTextField.text, !numEpisodes.isEmpty,
           let score = scoreTextField.text, !score.isEmpty,
           let genre = genreTextField.text, !genre.isEmpty,
           let type = typeTextField.text, !type.isEmpty,
           let status = statusTextField.text, !status.isEmpty {
            
            if let type = AnimeType(rawValue: type) {
                if let status = AnimeStatus(rawValue: status) {
                    if let numEpisodes = Int(numEpisodes) {
                        if let score = Double(score) {
                            
                            let result = addAnime(connection: connection, name: animeName, studio: studioName, synopsis: synopsis, premierDate: premiereDate, genre: genre, type: type, status: status, imageUrl: imageUrl, finalDate: finalDate, numEpisodes: numEpisodes, score: score)
                            
                            switch result {
                            case .success:
                                print("Added to DB")
                                showSuccessFailSquare(image: successImage)
                            case .failure(let error):
                                print("Not added to DB")
                                print(error)
                                showSuccessFailSquare(image: failImage)
                            }
                            
                        } else {
                            print("Score must be double")
                            showSuccessFailSquare(image: failImage)
                        }
                        
                    } else {
                        print("Number of episodes must be int")
                        showSuccessFailSquare(image: failImage)
                    }
                    
                } else {
                    print("Invalid anime status")
                    showSuccessFailSquare(image: failImage)
                }
            } else {
                print("Invalid anime type")
                showSuccessFailSquare(image: failImage)
            }
            
        } else {
            print("One of fields is empty")
            showSuccessFailSquare(image: failImage)
        }
    }
    
    
    private func showSuccessFailSquare(image: UIImageView) {

        if view.viewWithTag(999) != nil {
            return
        }
        
        let overlayView = UIView()
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        overlayView.tag = 999
        overlayView.alpha = 0
        view.addSubview(overlayView)
        
        NSLayoutConstraint.activate([
            overlayView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            overlayView.topAnchor.constraint(equalTo: view.topAnchor),
            overlayView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        let infoSquare = UIView()
        infoSquare.backgroundColor = .systemGray6
        infoSquare.layer.cornerRadius = 10
        infoSquare.translatesAutoresizingMaskIntoConstraints = false
        infoSquare.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        infoSquare.alpha = 0
        overlayView.addSubview(infoSquare)

        NSLayoutConstraint.activate([
            infoSquare.centerXAnchor.constraint(equalTo: overlayView.centerXAnchor),
            infoSquare.centerYAnchor.constraint(equalTo: overlayView.centerYAnchor),
            infoSquare.widthAnchor.constraint(equalToConstant: 310),
            infoSquare.heightAnchor.constraint(equalToConstant: 310)
        ])
        
        infoSquare.addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            image.centerXAnchor.constraint(equalTo: overlayView.centerXAnchor),
            image.centerYAnchor.constraint(equalTo: overlayView.centerYAnchor)
        ])
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            overlayView.alpha = 1
            infoSquare.alpha = 1
            infoSquare.transform = .identity

        }, completion: { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.hideInfoSquare()
            }
        })
    }

    @objc private func hideInfoSquare() {
        if let overlayView = view.viewWithTag(999) {
            UIView.animate(withDuration: 0.3, animations: {
                overlayView.alpha = 0
            }) { _ in
                overlayView.removeFromSuperview()
            }
        }
    }
}
