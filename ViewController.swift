//
//  ViewController.swift
//  DatabaseAnimeApp
//
//  Created by Родион Холодов on 02.12.2024.
//

import UIKit
import PostgresClientKit

class ViewController: UIViewController {

    let config = PostgresConfig.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        connectToDb()
    }
    
    private func connectToDb() {
        do {
            var configuration = PostgresClientKit.ConnectionConfiguration()
            configuration.host = config.host
            configuration.port = config.port
            configuration.database = config.database
            configuration.user = config.user
            configuration.credential = .scramSHA256(password: config.password)
            configuration.ssl = false // Отключение SSL
            
            let connection = try PostgresClientKit.Connection(configuration: configuration)
            defer { connection.close() }
            
            // Выполнение запроса
                let query = "SELECT * FROM anime;"
                let statement = try connection.prepareStatement(text: query)
                defer { statement.close() }

                let cursor = try statement.execute()
                defer { cursor.close() }

                // Обработка результатов
                for row in cursor {
                    let columns = try row.get().columns
                    for (index, column) in columns.enumerated() {
                        let value = column.postgresValue // Преобразуем значение в PostgresValue
                        print("Column \(index): \(value)")
                    }
                }
            
        } catch {
            print("Ошибка подключения: \(error)")
        }
    }

}

