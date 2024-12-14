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
    
    var detailsScrollView = UIScrollView()
    var detailsViews = [UIView]()

    
    
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
        //setOtherDetails()
        setHorizontalScrollView()

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

    private func setHorizontalScrollView() {
        let horizontalScrollView = UIScrollView()
        horizontalScrollView.translatesAutoresizingMaskIntoConstraints = false
        horizontalScrollView.showsHorizontalScrollIndicator = false
        horizontalScrollView.isPagingEnabled = true
        horizontalScrollView.decelerationRate = .fast
        view.addSubview(horizontalScrollView)
        
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        horizontalScrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            horizontalScrollView.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 20),
            horizontalScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40), // изменено на 20
            horizontalScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40), // изменено на -20
            horizontalScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            
            contentView.topAnchor.constraint(equalTo: horizontalScrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: horizontalScrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: horizontalScrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: horizontalScrollView.bottomAnchor),
            contentView.heightAnchor.constraint(equalTo: horizontalScrollView.heightAnchor)
        ])
        
        let synopsisView = UIView()
        let otherDetailsView = UIView()
        
//        to control views
//        contentView.layer.borderWidth = 1
//        synopsisView.layer.borderWidth = 1
//        otherDetailsView.layer.borderWidth = 1
        
        synopsisView.translatesAutoresizingMaskIntoConstraints = false
        otherDetailsView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(synopsisView)
        contentView.addSubview(otherDetailsView)
        
        setSynopsisView(in: synopsisView)
        NSLayoutConstraint.activate([
            synopsisView.topAnchor.constraint(equalTo: contentView.topAnchor),
            synopsisView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            synopsisView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            synopsisView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -80)
        ])
        
        setOtherDetails(in: otherDetailsView)
        NSLayoutConstraint.activate([
            otherDetailsView.topAnchor.constraint(equalTo: contentView.topAnchor),
            otherDetailsView.leadingAnchor.constraint(equalTo: synopsisView.trailingAnchor),
            otherDetailsView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            otherDetailsView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -80)
        ])
        
        NSLayoutConstraint.activate([
            otherDetailsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    private func setSynopsisView(in container: UIView) {

        let verticalScrollView = UIScrollView()
        verticalScrollView.translatesAutoresizingMaskIntoConstraints = false
        verticalScrollView.showsVerticalScrollIndicator = false
        verticalScrollView.isScrollEnabled = true
        container.addSubview(verticalScrollView)
        
        NSLayoutConstraint.activate([
            verticalScrollView.topAnchor.constraint(equalTo: container.topAnchor),
            verticalScrollView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            verticalScrollView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            verticalScrollView.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])

        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        verticalScrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: verticalScrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: verticalScrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: verticalScrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: verticalScrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: verticalScrollView.widthAnchor)
        ])
        
        synopsisAnime = build.synopsis
        synopsisLabel = build.synopsisLabel
        
        contentView.addSubview(synopsisLabel)
        contentView.addSubview(synopsisAnime)
        
        synopsisLabel.translatesAutoresizingMaskIntoConstraints = false
        synopsisAnime.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            synopsisLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            synopsisLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            synopsisLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            synopsisAnime.topAnchor.constraint(equalTo: synopsisLabel.bottomAnchor, constant: 5),
            synopsisAnime.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            synopsisAnime.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            synopsisAnime.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func setOtherDetails(in container: UIView) {
        
        informationLabel = build.informationLabel
        typeLabel = build.typeLabel
        animeTypeLabel = build.animeType
        
        container.addSubview(informationLabel)
        container.addSubview(typeLabel)
        container.addSubview(animeTypeLabel)
        
        informationLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        animeTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            informationLabel.topAnchor.constraint(equalTo: container.topAnchor),
            informationLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            
            typeLabel.topAnchor.constraint(equalTo: informationLabel.bottomAnchor, constant: 20),
            typeLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            
            animeTypeLabel.leadingAnchor.constraint(equalTo: typeLabel.trailingAnchor, constant: 3),
            animeTypeLabel.topAnchor.constraint(equalTo: informationLabel.bottomAnchor, constant: 20)
        ])
    }

}
