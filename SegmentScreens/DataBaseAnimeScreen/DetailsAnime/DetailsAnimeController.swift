//
//  DetailsAnimeController.swift
//  DatabaseAnimeApp
//
//  Created by Родион Холодов on 11.12.2024.
//

import UIKit
import Foundation
import SDWebImage

class DetailsAnimeController: UIViewController, UIScrollViewDelegate {
    
    private let build = DetailsAnimeView.shared
    
    var viewModel: DetailsAnimeViewModel
    
    var image = UIImageView()
    var name = UILabel()
    var goBackButton = UIButton()
    var synopsisLabel = UILabel()
    var synopsisAnime = UILabel()
    var synopsisView = UIView()
    
    var informationLabel = UILabel()
    var typeLabel = UILabel()
    var animeTypeLabel = UILabel()
    var informationView = UIView()

    
    
    init(viewModel: DetailsAnimeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setName()
        setImage()

        setGoBackButton()
        //setSynopsisView()
        setOtherDetails()
        configView()
        
    }
    
    private func setImage() {
        image = build.image
        image.round()
        view.addSubview(image)
        
        NSLayoutConstraint.activate([
            //image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            image.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 30),
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
            //name.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 50)
            name.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10)
        ])
    }
    
    private func configView() {
        
        view.backgroundColor = .systemGray6
        title = viewModel.name
        name.text = viewModel.name
        synopsisAnime.text = viewModel.synopsis
        animeTypeLabel.text = viewModel.type
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
    
    private func setSynopsisView() {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        scrollView.isScrollEnabled = true
        
        synopsisView.translatesAutoresizingMaskIntoConstraints = false
        

        synopsisAnime = build.synopsis
        synopsisLabel = build.synopsisLabel
        
        view.addSubview(synopsisView)
        synopsisView.addSubview(synopsisLabel)
        scrollView.addSubview(synopsisAnime)
        synopsisView.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            synopsisView.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 20),
            synopsisView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            synopsisView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            synopsisView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            synopsisLabel.topAnchor.constraint(equalTo: synopsisView.topAnchor),
            synopsisLabel.leadingAnchor.constraint(equalTo: synopsisView.leadingAnchor),
            synopsisLabel.trailingAnchor.constraint(equalTo: synopsisView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: synopsisLabel.bottomAnchor, constant: 5),
            scrollView.leadingAnchor.constraint(equalTo: synopsisView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: synopsisView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: synopsisView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            synopsisAnime.topAnchor.constraint(equalTo: scrollView.topAnchor),
            synopsisAnime.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            synopsisAnime.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            synopsisAnime.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            synopsisAnime.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        
        ])
    }
    
    private func setOtherDetails() {
        informationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(informationView)
        
        informationLabel = build.informationLabel
        typeLabel = build.typeLabel
        animeTypeLabel = build.animeType
        
        informationView.addSubview(informationLabel)
        informationView.addSubview(typeLabel)
        informationView.addSubview(animeTypeLabel)
        
        NSLayoutConstraint.activate([
            informationView.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 20),
            informationView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            informationView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            informationView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            informationLabel.topAnchor.constraint(equalTo: informationView.topAnchor),
            informationLabel.centerXAnchor.constraint(equalTo: informationView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            typeLabel.topAnchor.constraint(equalTo: informationLabel.bottomAnchor, constant: 20),
            typeLabel.leadingAnchor.constraint(equalTo: informationView.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            animeTypeLabel.leadingAnchor.constraint(equalTo: typeLabel.trailingAnchor, constant: 3),
            animeTypeLabel.topAnchor.constraint(equalTo: informationLabel.bottomAnchor, constant: 20)
        ])
    }
}
