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
    
    private func setBannerImage() {
        view.addSubview(successImage)
        successImage.image = .successLogin2
        
        
        NSLayoutConstraint.activate([
            successImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            successImage.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
    }
}
