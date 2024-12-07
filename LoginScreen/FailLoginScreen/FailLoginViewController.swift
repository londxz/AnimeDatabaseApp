//
//  NextViewController.swift
//  DatabaseAnimeApp
//
//  Created by Родион Холодов on 07.12.2024.
//

import Foundation
import UIKit

class FailLoginViewController: UIViewController {
    
    let text: String
    
    init(text: String) {
        self.text = text
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .systemGray5
        setStatusTextLabelWithContainer()
        setBannerImage()
    }
    
    lazy var statusTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Verdana-BoldItalic", size: 20)
        
       return label
    }()
    
    lazy var statusContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        return view
    }()
    
    lazy var failImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        
        NSLayoutConstraint.activate([
            image.widthAnchor.constraint(equalToConstant: 200),
            image.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        return image
    }()
    
    
    private func setBannerImage() {
        view.addSubview(failImage)
        failImage.image = .failLogin
        
        
        NSLayoutConstraint.activate([
            failImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            failImage.bottomAnchor.constraint(equalTo: statusContainerView.topAnchor, constant: -60)
        ])
        
    }
    private func setStatusTextLabelWithContainer() {
        view.addSubview(statusContainerView)
        statusContainerView.addSubview(statusTextLabel)
        statusContainerView.backgroundColor = .failPurple
        statusTextLabel.text = self.text
        statusTextLabel.textColor = .systemGray5
        
        NSLayoutConstraint.activate([
            statusContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            statusContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            statusContainerView.heightAnchor.constraint(equalToConstant: 50),
            statusContainerView.widthAnchor.constraint(equalToConstant: 340)
        ])
        
        NSLayoutConstraint.activate([
            statusTextLabel.centerYAnchor.constraint(equalTo: statusContainerView.centerYAnchor),
            statusTextLabel.centerXAnchor.constraint(equalTo: statusContainerView.centerXAnchor)
        ])
    }
}
