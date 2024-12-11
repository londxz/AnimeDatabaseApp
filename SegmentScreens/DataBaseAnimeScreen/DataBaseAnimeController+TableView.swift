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
    
    func registerCells() {
        tableView.register(AnimeCell.self, forCellReuseIdentifier: AnimeCell.identifier)
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animeViewModel.numberOfRows(in: section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return animeViewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AnimeCell.identifier, for: indexPath) as? AnimeCell else {
            return UITableViewCell()
        }
        
        /* function getData is nested with sql func getAnimeData => too much indexes
        that's why we need to guard
        */

        
        guard indexPath.row < self.cellDataSource.count else {
            return cell
        }


        let cellViewModel = cellDataSource[indexPath.row]
        cell.setupCell(viewModel: cellViewModel)
        return cell

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let animeId = cellDataSource[indexPath.row].id
        self.openDetail(animeId: animeId)
    }
    
    
}
