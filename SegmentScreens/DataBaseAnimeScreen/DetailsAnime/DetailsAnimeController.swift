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
    
    let viewModel: DetailsAnimeViewModel
    
    var image = UIImageView()
    var name = UILabel()
    var goBackButton = UIButton()
    var synopsisLabel = UILabel()
    var synopsisAnime = UILabel()
    
    var informationLabel = UILabel()
    var typeLabel = UILabel()
    var animeTypeLabel = UILabel()
    
    var episodes = UILabel()
    var aired = UILabel()
    var studio = UILabel()
    var genre = UILabel()
    var airedLabel = UILabel()
    var id = UILabel()
    var idLabel = UILabel()
    var lastChange = UILabel()
    var lastChangeLabel = UILabel()
    var otherNamesLabel = UILabel()
    var charactersLabel = UILabel()
    
    var genreQuestionButton = UIButton()
    var studioQuestionButton = UIButton()
    var otherNamesQuestionButton = UIButton()
    var charactersQuestionButton = UIButton()
    
    var studioData = [String: String]()
    var genreData = [String: String]()
    var animeNamesData = [String: (String, String)]()
    var charactersData = [String: (String, String, String)]()

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
        setHorizontalScrollView()
        setGenreQuestionButton()
        setStudioQuestionButton()
        setOtherNamesQuestionButton()
        setCharactersQuestionButton()
        configView()
        
        
    }

    private func setImage() {
        image = build.image
        image.round()
        view.addSubview(image)
        
        NSLayoutConstraint.activate([
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
            name.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10)
        ])
    }
    
    private func configView() {
        
        view.backgroundColor = .systemGray6
        title = viewModel.name
        name.text = viewModel.name
        synopsisAnime.text = viewModel.synopsis
        animeTypeLabel.text = viewModel.type
        episodes.text = String(viewModel.numEpisodes)
        aired.text = "\(viewModel.premiereDate) to \(viewModel.finalDate)"
        studio.text = viewModel.studio
        genre.text = viewModel.genre
        id.text = String(viewModel.id)
        lastChange.text = viewModel.updatedAt
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
        episodes = build.episodes
        aired = build.aired
        studio = build.studio
        genre = build.genre
        airedLabel = build.airedLabel
        id = build.id
        idLabel = build.idLabel
        lastChange = build.lastChange
        lastChangeLabel = build.lastChangeLabel
        otherNamesLabel = build.otherNamesLabel
        charactersLabel = build.charactersLabel
    
        let episodesLabel = build.episodesLabel
        let studioLabel = build.studioLable
        let genreLabel = build.genreLabel
        
        
        
        container.addSubview(informationLabel)
        container.addSubview(typeLabel)
        container.addSubview(animeTypeLabel)
        container.addSubview(episodes)
        container.addSubview(episodesLabel)
        container.addSubview(aired)
        container.addSubview(airedLabel)
        container.addSubview(studio)
        container.addSubview(studioLabel)
        container.addSubview(genre)
        container.addSubview(genreLabel)
        container.addSubview(id)
        container.addSubview(idLabel)
        container.addSubview(lastChange)
        container.addSubview(lastChangeLabel)
        container.addSubview(otherNamesLabel)
        container.addSubview(charactersLabel)
        
        informationLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        animeTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            informationLabel.topAnchor.constraint(equalTo: container.topAnchor),
            informationLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            
            genreLabel.topAnchor.constraint(equalTo: informationLabel.bottomAnchor, constant: 20),
            genreLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            
            genre.leadingAnchor.constraint(equalTo: genreLabel.trailingAnchor, constant: 3),
            genre.topAnchor.constraint(equalTo: informationLabel.bottomAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            typeLabel.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 10),
            typeLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            
            animeTypeLabel.leadingAnchor.constraint(equalTo: typeLabel.trailingAnchor, constant: 3),
            animeTypeLabel.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            episodesLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 10),
            episodesLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            
            episodes.leadingAnchor.constraint(equalTo: episodesLabel.trailingAnchor, constant: 3),
            episodes.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            airedLabel.topAnchor.constraint(equalTo: episodes.bottomAnchor, constant: 10),
            airedLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            
            aired.leadingAnchor.constraint(equalTo: airedLabel.trailingAnchor, constant: 3),
            aired.topAnchor.constraint(equalTo: episodes.bottomAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            studioLabel.topAnchor.constraint(equalTo: aired.bottomAnchor, constant: 10),
            studioLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            
            studio.leadingAnchor.constraint(equalTo: studioLabel.trailingAnchor, constant: 3),
            studio.topAnchor.constraint(equalTo: aired.bottomAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            idLabel.topAnchor.constraint(equalTo: studio.bottomAnchor, constant: 10),
            idLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            
            id.leadingAnchor.constraint(equalTo: idLabel.trailingAnchor, constant: 3),
            id.topAnchor.constraint(equalTo: studio.bottomAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            lastChangeLabel.topAnchor.constraint(equalTo: id.bottomAnchor, constant: 10),
            lastChangeLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            
            lastChange.leadingAnchor.constraint(equalTo: lastChangeLabel.trailingAnchor, constant: 3),
            lastChange.topAnchor.constraint(equalTo: id.bottomAnchor, constant: 10)
        ])
        NSLayoutConstraint.activate([
            otherNamesLabel.topAnchor.constraint(equalTo: lastChange.bottomAnchor, constant: 10),
            otherNamesLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            charactersLabel.topAnchor.constraint(equalTo: otherNamesLabel.bottomAnchor, constant: 10),
            charactersLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor)
        ])
    }
    
    private func setGenreQuestionButton() {
        genreQuestionButton = build.genreQuestionButton
        genreQuestionButton.addTarget(self, action: #selector(showGenreInfoSquare), for: .touchUpInside)
        view.addSubview(genreQuestionButton)
        
        NSLayoutConstraint.activate([
            genreQuestionButton.leadingAnchor.constraint(equalTo: genre.trailingAnchor, constant: 5),
            genreQuestionButton.bottomAnchor.constraint(equalTo: genre.bottomAnchor)
        ])
    }
    
    private func setStudioQuestionButton() {
        studioQuestionButton = build.studioQuestionButton
        studioQuestionButton.addTarget(self, action: #selector(showStudioInfoSquare), for: .touchUpInside)
        view.addSubview(studioQuestionButton)
        
        NSLayoutConstraint.activate([
            studioQuestionButton.leadingAnchor.constraint(equalTo: studio.trailingAnchor, constant: 5),
            studioQuestionButton.bottomAnchor.constraint(equalTo: studio.bottomAnchor)
        ])
    }
    
    private func setOtherNamesQuestionButton() {
        otherNamesQuestionButton = build.otherNamesQuestionButton
        otherNamesQuestionButton.addTarget(self, action: #selector(showOtherNamesInfoSquare), for: .touchUpInside)
        view.addSubview(otherNamesQuestionButton)
        
        NSLayoutConstraint.activate([
            otherNamesQuestionButton.leadingAnchor.constraint(equalTo: otherNamesLabel.trailingAnchor, constant: 5),
            otherNamesQuestionButton.bottomAnchor.constraint(equalTo: otherNamesLabel.bottomAnchor)
        ])
    }
    
    private func setCharactersQuestionButton() {
        charactersQuestionButton = build.charactersQuestionButton
        charactersQuestionButton.addTarget(self, action: #selector(showCharactersInfoSquare), for: .touchUpInside)
        view.addSubview(charactersQuestionButton)
        
        NSLayoutConstraint.activate([
            charactersQuestionButton.leadingAnchor.constraint(equalTo: charactersLabel.trailingAnchor, constant: 5),
            charactersQuestionButton.bottomAnchor.constraint(equalTo: charactersLabel.bottomAnchor)
        ])
    }
    
    
    @objc private func showStudioInfoSquare() {
        
        if view.viewWithTag(999) != nil {
            return
        }
        
        getDataForStudio()
        
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
        
        studioData.forEach { (name, description) in
            if (name == studio.text) {
                setStudioOrGenreInfo(square: infoSquare, name: name, data: studioData)
            }
        }
        
        let closeButton = UIButton(type: .system)
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.setTitleColor(.black, for: .normal)
        closeButton.tintColor = .black
        closeButton.alpha = 0.3
        closeButton.addTarget(self, action: #selector(hideInfoSquare), for: .touchUpInside)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        infoSquare.addSubview(closeButton)
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: infoSquare.topAnchor, constant: 10),
            closeButton.trailingAnchor.constraint(equalTo: infoSquare.trailingAnchor, constant: -10)
        ])
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            overlayView.alpha = 1
            infoSquare.alpha = 1
            infoSquare.transform = .identity
            
        }, completion: nil)
    }
    
    @objc private func showGenreInfoSquare() {
        
        if view.viewWithTag(999) != nil {
            return
        }
        
        getDataForGenre()
        
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
        
        genreData.forEach { (name, description) in
            if (name == genre.text) {
                setStudioOrGenreInfo(square: infoSquare, name: name, data: genreData)
            }
        }
        
        let closeButton = UIButton(type: .system)
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.setTitleColor(.black, for: .normal)
        closeButton.tintColor = .black
        closeButton.alpha = 0.3
        closeButton.addTarget(self, action: #selector(hideInfoSquare), for: .touchUpInside)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        infoSquare.addSubview(closeButton)
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: infoSquare.topAnchor, constant: 10),
            closeButton.trailingAnchor.constraint(equalTo: infoSquare.trailingAnchor, constant: -10)
        ])
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            overlayView.alpha = 1
            infoSquare.alpha = 1
            infoSquare.transform = .identity
            
        }, completion: nil)
    }
    
    @objc private func showOtherNamesInfoSquare() {
        
        if view.viewWithTag(999) != nil {
            return
        }
        
        getDataForAnimeNames()
        
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
        
        animeNamesData.forEach { (animeId, names) in
            
            //let (romaji, japan) = names
            
            if (animeId == id.text) {
                setOtherNamesInfo(square: infoSquare, id: animeId, data: names)
            }
        }
        
        let closeButton = UIButton(type: .system)
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.setTitleColor(.black, for: .normal)
        closeButton.tintColor = .black
        closeButton.alpha = 0.3
        closeButton.addTarget(self, action: #selector(hideInfoSquare), for: .touchUpInside)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        infoSquare.addSubview(closeButton)
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: infoSquare.topAnchor, constant: 10),
            closeButton.trailingAnchor.constraint(equalTo: infoSquare.trailingAnchor, constant: -10)
        ])
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            overlayView.alpha = 1
            infoSquare.alpha = 1
            infoSquare.transform = .identity
            
        }, completion: nil)
    }
    
    @objc private func showCharactersInfoSquare() {
        
        if view.viewWithTag(999) != nil {
            return
        }
        
        getDataForCharacters()
        
        
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
        
        charactersData.forEach { (characterId, moreData) in
            
            let (characerName, animeId, characterDescription) = moreData
            
            if animeId == id.text {
                let matchingCharacters = charactersData.values.filter { $0.1 == animeId }
                setCharactersInfo(square: infoSquare, id: animeId, data: matchingCharacters)
            }
        }
        
        let closeButton = UIButton(type: .system)
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.setTitleColor(.black, for: .normal)
        closeButton.tintColor = .black
        closeButton.alpha = 0.3
        closeButton.addTarget(self, action: #selector(hideInfoSquare), for: .touchUpInside)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        infoSquare.addSubview(closeButton)
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: infoSquare.topAnchor, constant: 10),
            closeButton.trailingAnchor.constraint(equalTo: infoSquare.trailingAnchor, constant: -10)
        ])
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            overlayView.alpha = 1
            infoSquare.alpha = 1
            infoSquare.transform = .identity
            
        }, completion: nil)
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
    
    private func setStudioOrGenreInfo(square: UIView, name: String, data: [String: String]) {
        let studio = UILabel()
        studio.translatesAutoresizingMaskIntoConstraints = false
        studio.font = UIFont(name: "Verdana-Bold", size: 18)
        studio.text = name
        
        let description = UILabel()
        description.translatesAutoresizingMaskIntoConstraints = false
        description.font = UIFont(name: "PingFangTC-Medium", size: 17)
        description.numberOfLines = 0
        description.baselineAdjustment = .alignCenters
        description.textAlignment = .center
        description.text = data[name]
        
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsVerticalScrollIndicator = false
        scroll.isPagingEnabled = false
        scroll.isScrollEnabled = true
        
        scroll.addSubview(description)
        square.addSubview(studio)
        square.addSubview(scroll)
        
        NSLayoutConstraint.activate([
            studio.centerXAnchor.constraint(equalTo: square.centerXAnchor),
            studio.topAnchor.constraint(equalTo: square.topAnchor, constant: 20),
            
            scroll.leadingAnchor.constraint(equalTo: square.leadingAnchor, constant: 20),
            scroll.trailingAnchor.constraint(equalTo: square.trailingAnchor, constant: -20),
            scroll.topAnchor.constraint(equalTo: studio.bottomAnchor, constant: 10),
            scroll.bottomAnchor.constraint(equalTo: square.bottomAnchor, constant: -20),
            
            description.leadingAnchor.constraint(equalTo: scroll.leadingAnchor),
            description.trailingAnchor.constraint(equalTo: scroll.trailingAnchor),
            description.topAnchor.constraint(equalTo: scroll.topAnchor),
            description.bottomAnchor.constraint(equalTo: scroll.bottomAnchor),
            description.widthAnchor.constraint(equalTo: scroll.widthAnchor)
        ])

    }
    
    private func setOtherNamesInfo(square: UIView, id: String, data: (String, String)) {
        
        let otherNames = UILabel()
        otherNames.translatesAutoresizingMaskIntoConstraints = false
        otherNames.font = UIFont(name: "Verdana-Bold", size: 18)
        otherNames.text = "Other names"
        
        let romajiNameLabel = UILabel()
        romajiNameLabel.translatesAutoresizingMaskIntoConstraints = false
        romajiNameLabel.font = UIFont(name: "Verdana-Bold", size: 18)
        romajiNameLabel.text = "Romaji: "
        
        let romajiName = UILabel()
        romajiName.translatesAutoresizingMaskIntoConstraints = false
        romajiName.font = UIFont(name: "PingFangTC-Medium", size: 17)
        romajiName.numberOfLines = 0
        romajiName.text = data.0
        
        let japanNameLabel = UILabel()
        japanNameLabel.translatesAutoresizingMaskIntoConstraints = false
        japanNameLabel.font = UIFont(name: "Verdana-Bold", size: 18)
        japanNameLabel.text = "Japanese: "
        
        let japanName = UILabel()
        japanName.translatesAutoresizingMaskIntoConstraints = false
        japanName.font = UIFont(name: "PingFangTC-Medium", size: 17)
        japanName.numberOfLines = 0
        japanName.text = data.1
        
        square.addSubview(otherNames)
        square.addSubview(romajiName)
        square.addSubview(romajiNameLabel)
        square.addSubview(japanName)
        square.addSubview(japanNameLabel)
        
        NSLayoutConstraint.activate([
            otherNames.centerXAnchor.constraint(equalTo: square.centerXAnchor),
            otherNames.topAnchor.constraint(equalTo: square.topAnchor, constant: 20),
            
            romajiNameLabel.leadingAnchor.constraint(equalTo: square.leadingAnchor, constant: 20),
            romajiNameLabel.topAnchor.constraint(equalTo: otherNames.bottomAnchor, constant: 20),
            
            romajiName.leadingAnchor.constraint(equalTo: romajiNameLabel.trailingAnchor, constant: 3),
            romajiName.trailingAnchor.constraint(equalTo: square.trailingAnchor, constant:  -20),
            romajiName.bottomAnchor.constraint(equalTo: romajiNameLabel.bottomAnchor),
            
            
            japanNameLabel.topAnchor.constraint(equalTo: romajiName.bottomAnchor, constant: 20),
            japanNameLabel.leadingAnchor.constraint(equalTo: square.leadingAnchor, constant: 20),
            
            
            japanName.leadingAnchor.constraint(equalTo: japanNameLabel.trailingAnchor, constant: 3),
            japanName.trailingAnchor.constraint(equalTo: square.trailingAnchor, constant: -20),
            japanName.bottomAnchor.constraint(equalTo: japanNameLabel.bottomAnchor)
        ])

    }
    
    private func setCharactersInfo(square: UIView, id: String, data: [(String, String, String)]) {
        
        square.subviews.forEach { $0.removeFromSuperview() }

        let charactersLabel = UILabel()
        charactersLabel.translatesAutoresizingMaskIntoConstraints = false
        charactersLabel.font = UIFont(name: "Verdana-Bold", size: 18)
        charactersLabel.text = "Characters"
        
        let charactersInfo = UILabel()
        charactersInfo.translatesAutoresizingMaskIntoConstraints = false
        charactersInfo.font = UIFont(name: "PingFangTC-Medium", size: 17)
        charactersInfo.numberOfLines = 0
        charactersInfo.textAlignment = .natural


        let formattedText = data
            .map { "Character \($0.0) has description: \($0.2)" }
            .joined(separator: "\n\n ")

        charactersInfo.text = formattedText

        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = true
        scrollView.isScrollEnabled = true
        
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(contentView)
        contentView.addSubview(charactersInfo)
        square.addSubview(charactersLabel)
        square.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            charactersLabel.centerXAnchor.constraint(equalTo: square.centerXAnchor),
            charactersLabel.topAnchor.constraint(equalTo: square.topAnchor, constant: 20),
        ])
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: square.leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: square.trailingAnchor, constant: -20),
            scrollView.topAnchor.constraint(equalTo: charactersLabel.bottomAnchor, constant: 10),
            scrollView.bottomAnchor.constraint(equalTo: square.bottomAnchor, constant: -20),
        ])
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
        
        NSLayoutConstraint.activate([
            charactersInfo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            charactersInfo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            charactersInfo.topAnchor.constraint(equalTo: contentView.topAnchor),
            charactersInfo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    
    //MARK: - Work with data for squares
    
    private func getNumerOfStudios() -> Int {
        if let connection = getConnectionToDb(),
           let res = getAllTablesData(connection: connection) {
            defer { connection.close() }
            return res["studio"]?.count ?? 0
        }
        return 0
    }
    
    private func getDataForStudio() {
        let numRows = getNumerOfStudios()
        
        guard let connection = getConnectionToDb() else { return }
        defer { connection.close() }

        guard let studios = getStudioData(connection: connection, numRows: numRows) else {
             print("getDataForStudio: Ошибка получения данных из базы")
            return
         }

        let _ : [()] = studios.map { studio in
            let studioName = studio.name
            studioData[studioName] = studio.description
         }
    }
    
    private func getNumerOfGenres() -> Int {
        if let connection = getConnectionToDb(),
           let res = getAllTablesData(connection: connection) {
            defer { connection.close() }
            return res["genre"]?.count ?? 0
        }
        return 0
    }
    
    private func getDataForGenre() {
        let numRows = getNumerOfGenres()
        
        guard let connection = getConnectionToDb() else { return }
        defer { connection.close() }

        guard let genres = getGenreData(connection: connection, numRows: numRows) else {
             print("getDataForGenre: Ошибка получения данных из базы")
            return
         }

        let _ : [()] = genres.map { genre in
            let genreName = genre.name
            genreData[genreName] = genre.description
         }
    }
    
    private func getNumerOfAnimeNames() -> Int {
        if let connection = getConnectionToDb(),
           let res = getAllTablesData(connection: connection) {
            defer { connection.close() }
            return res["anime_name_locale"]?.count ?? 0
        }
        return 0
    }
    
    private func getDataForAnimeNames() {
        let numRows = getNumerOfAnimeNames()
        
        guard let connection = getConnectionToDb() else { return }
        defer { connection.close() }

        guard let names = getAnimeNameLocaleData(connection: connection, numRows: numRows) else {
             print("getDataForAnimeNames: Ошибка получения данных из базы")
            return
         }

        let _ : [()] = names.map { name in
            let id = name.anime_id
            let romaji = name.romaji_name
            let japan = name.japanese_name
            animeNamesData[String(id)] = (romaji, japan)
         }
        //print(animeNamesData)
    }
    
    private func getNumerOfCharacters() -> Int {
        if let connection = getConnectionToDb(),
           let res = getAllTablesData(connection: connection) {
            defer { connection.close() }
            return res["character"]?.count ?? 0
        }
        return 0
    }
    
    private func getDataForCharacters() {
        let numRows = getNumerOfCharacters()
        
        guard let connection = getConnectionToDb() else { return }
        defer { connection.close() }

        guard let characters = getCharacterData(connection: connection, numRows: numRows) else {
             print("getDataForCharacters: Ошибка получения данных из базы")
            return
         }

        let _ : [()] = characters.map { character in
            let id = character.id
            let name = character.name
            let anime_id = character.anime_id
            let description = character.description
            charactersData[String(id)] = (name, String(anime_id), description)
         }
        print(charactersData)
    }
}
