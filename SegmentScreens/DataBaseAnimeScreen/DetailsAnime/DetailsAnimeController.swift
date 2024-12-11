//
//  DetailsAnimeController.swift
//  DatabaseAnimeApp
//
//  Created by Родион Холодов on 11.12.2024.
//

import UIKit
import Foundation
import SDWebImage

class DetailsAnimeController: UIViewController {
    
    private let build = DetailsAnimeView.shared
    
    var viewModel: DetailsAnimeViewModel
    
    var image = UIImageView()
    var name = UILabel()
    var goBackButton = UIButton()
    
    init(viewModel: DetailsAnimeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setImage()
        setName()
        setGoBackButton()
        configView()
        
    }
    
    private func setImage() {
        image = build.image
        image.round()
        view.addSubview(image)
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            image.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            image.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.4),
            image.heightAnchor.constraint(equalTo: image.widthAnchor, multiplier: 1.5)
        ])
    }
    
    private func setName() {
        name = build.name
        view.addSubview(name)
        
        NSLayoutConstraint.activate([
            name.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            name.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 50)
        ])
    }
    
    private func configView() {
        
        view.backgroundColor = .systemGray5
        self.title = viewModel.name
        name.text = viewModel.name
        image.sd_setImage(with: viewModel.image)
    }
    
    private func setGoBackButton() {
        goBackButton = build.goBackButton
        goBackButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        view.addSubview(goBackButton)
        
        NSLayoutConstraint.activate([
            goBackButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            goBackButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15)
        ])
    }
    
    @objc func goBack() {
        dismiss(animated: true)
    }

    
    
    
}
