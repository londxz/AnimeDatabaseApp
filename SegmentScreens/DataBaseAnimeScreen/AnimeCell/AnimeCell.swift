//
//  AnimeCell.swift
//  DatabaseAnimeApp
//
//  Created by Родион Холодов on 09.12.2024.
//

import UIKit
import SDWebImage

class AnimeCell: UITableViewCell {
    
    private let build = AnimeCellView()
    
    var backView: UIView!
    var name: UILabel!
    var premiereDate: UILabel!
    var score: UILabel!
    var image: UIImageView!
    
    public static var identifier: String {
        get {
            return "AnimeCell"
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setCellItems()
        roundEdges()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setCellItems()
        roundEdges()
    }

    
    private func setView() {
        backView = build.backView
        contentView.addSubview(backView)
        
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
    private func setImage() {
        image = build.imageView
        backView.addSubview(image)
        
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 8),
            image.topAnchor.constraint(equalTo: backView.topAnchor, constant: 5),
            image.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -5),
            image.heightAnchor.constraint(equalTo: image.widthAnchor, multiplier: 1.5)
            
        ])
    
    }
    
    private func setNameLabel() {
        name = build.nameLabel
        backView.addSubview(name)
        
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: backView.topAnchor),
            name.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 8),
            name.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -8)
        ])
    
    }
    
    
    private func setDateLabel() {
        premiereDate = build.dateLabel
        backView.addSubview(premiereDate)
        
        NSLayoutConstraint.activate([
            premiereDate.topAnchor.constraint(equalTo: name.bottomAnchor,constant: 8),
            premiereDate.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 8),
            premiereDate.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -8)
        ])
    
    }
    
    private func setRateLabel() {
        score = build.rateLabel
        backView.addSubview(score)
        
        NSLayoutConstraint.activate([
            score.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -8),
            score.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 8),
            score.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -8),
            score.topAnchor.constraint(equalTo: premiereDate.bottomAnchor, constant: 8)
        ])
    
    }
    
    private func setCellItems() {
        setView()
        setImage()
        setNameLabel()
        setDateLabel()
        setRateLabel()
    
    }
    
    private func roundEdges() {
        backView.round()
        image.round(5)
    }
    
    func setupCell(viewModel: AnimeCellViewModel) {
        self.name.text = viewModel.name
        self.premiereDate.text = viewModel.premiereDate
        self.score.text = viewModel.score
        self.image.sd_setImage(with: viewModel.imageUrl)
        
    }
}
