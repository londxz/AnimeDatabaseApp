//
//  ViewController.swift
//  DatabaseAnimeApp
//
//  Created by Родион Холодов on 02.12.2024.
//

import UIKit
import PostgresClientKit

class MainViewController: UIViewController {

    let config = PostgresConfig.shared
    
    //for ids tracking
    var ids = Id.shared

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray

        guard let connection = getConnectionToDb() else { return }
        defer { connection.close() }
        getAllTablesData(connection: connection)
        
    }
    
    
}

