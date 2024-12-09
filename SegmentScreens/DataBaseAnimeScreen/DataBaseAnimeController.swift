//
//  DataBaseAnimeScreen.swift
//  DatabaseAnimeApp
//
//  Created by Родион Холодов on 09.12.2024.
//

import UIKit

class DataBaseAnimeController: UIViewController {
    
    private let build = DatabaseAnimeView.shared
    
    var segmentControl = CustomSegmentControl()
    var tableView = UITableView()
    
    override func viewDidLoad() {
        view.backgroundColor = .systemGray5
        
        setSegmentControl()
        configTableView()
        setTableView()
    }
    
    private func setSegmentControl() {
        segmentControl = build.segmentControl
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentControl)
        
        NSLayoutConstraint.activate([
            segmentControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            segmentControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            segmentControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func setTableView() {
        tableView = build.tableView
        tableView.backgroundColor = .systemGray5
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 5),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
