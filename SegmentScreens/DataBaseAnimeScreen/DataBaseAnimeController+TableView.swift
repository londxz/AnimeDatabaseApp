//
//  DataBaseAnimeController+TableView.swift
//  DatabaseAnimeApp
//
//  Created by Родион Холодов on 09.12.2024.
//

import UIKit

extension DataBaseAnimeController: UITableViewDelegate, UITableViewDataSource {
    
    func configTableView() {
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.backgroundColor = .systemGray5
        
        self.registerCells()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AnimeCell.identifier, for: indexPath) as? AnimeCell else {
            return UITableViewCell()
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    
    func registerCells() {
        tableView.register(AnimeCell.self, forCellReuseIdentifier: AnimeCell.identifier)
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}
