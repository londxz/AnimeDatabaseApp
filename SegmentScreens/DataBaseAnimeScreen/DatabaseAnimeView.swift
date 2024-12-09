//
//  DatabaseAnimeView.swift
//  DatabaseAnimeApp
//
//  Created by Родион Холодов on 09.12.2024.
//

import UIKit

class DatabaseAnimeView {
    
    // make it singleton
    static let shared = DatabaseAnimeView()
    private init() {}
    
    
    lazy var segmentControl: CustomSegmentControl = {
        let segment = CustomSegmentControl()
        segment.commaSeparatedButtonTitles = "All anime, Add anime"
        segment.style = .light
        return segment
    }()
    
    lazy var tableView: UITableView = {
       let tbView = UITableView()
        tbView.translatesAutoresizingMaskIntoConstraints = false
        return tbView
    }()
}
