//
//  StudioViewModel.swift
//  DatabaseAnimeApp
//
//  Created by Родион Холодов on 14.12.2024.
//

import Foundation

class StudioViewModel {
    
    var dataSource: [StudioModel]?
    var studioDataSource = [StudioViewModel]()
    
    var name: String
    var description: String
    
    init(studio: StudioModel) {
        self.name = studio.name
        self.description = studio.description
    }
    
    func numberOfStudios(in section: Int) -> Int {
        if let connection = getConnectionToDb(),
           let res = getAllTablesData(connection: connection) {
            defer { connection.close() }
            return res["studio"]?.count ?? 0
        }
        return 0
    }
    
    func getStudioVMData() {
        if let connection = getConnectionToDb() {
            defer { connection.close() }
            
            if let res = getStudioData(connection: connection, numRows: numberOfStudios(in: 0)) {
                self.dataSource = res
                self.mapStudioData()
                print(res.count)
            } else {
                print("Failed to fetch data.")
            }
        }
    }
    
    func mapStudioData() {
        self.studioDataSource = self.dataSource?.compactMap({ StudioViewModel(studio: $0) }) ?? []
    }
}
