//
//  AnimeViewModel.swift
//  DatabaseAnimeApp
//
//  Created by Родион Холодов on 10.12.2024.
//

import Foundation

class AnimeViewModel {
    
    var dataSource: [AnimeModel]?
    var cellDataSource: Observable<[AnimeCellViewModel]> = Observable(nil)
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows(in section: Int) -> Int {
        if let connection = getConnectionToDb(),
           let res = getAllTablesData(connection: connection) {
            defer { connection.close() }
            return res["anime"]?.count ?? 0
        }
        return 0
    }
    
    func getData() {
        if let connection = getConnectionToDb() {
            defer { connection.close() }
            
            if let res = getAnimeData(connection: connection, numRows: numberOfRows(in: 0)) {
                self.dataSource = res
                self.mapCellData()
                print(res.count)
            } else {
                print("Failed to fetch data.")
            }
            
            
        }
    }
    
    func mapCellData() {
        self.cellDataSource.value = self.dataSource?.compactMap({ AnimeCellViewModel(anime: $0) })
    }
    
    func injectAnime(with id: Int) -> AnimeModel? {
        print("injecting anime for id \(String(describing: dataSource?[0].id))")
        guard let anime = dataSource?.first(where: { $0.id == id}) else {
            return nil
        }
        return anime
    }
}
