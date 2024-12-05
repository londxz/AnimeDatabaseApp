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
    
    //for ids tracking
    var ids = Id.shared
    /*
     let genreName = "Genre from app3"
     let genreDescription = "Description from app3"
    */
    
    /*
     let studioName = "Studio from app"
     let studioDescription = "Description from app"
     */

    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let connection = getConnectionToDb() else { return }
        defer { connection.close() }
        
        addGenre(connection: connection, name: "ActioN",
                 description: "The action film is a film genre that predominantly features chase sequences, fights, shootouts, explosions, and stunt work.")
        addStudio(connection: connection, name: "Wit Studio", 
                  description: "Japanese animation studio founded on June 1, 2012, by producers at Production I.G as a subsidiary of IG Port. It is headquartered in Musashino, Tokyo, with Production I.G producer George Wada as president and Tetsuya Nakatake, also a producer at Production I.G, as a director of the studio. The studio gained notability for producing Attack on Titan (the first three seasons), Great Pretender, Ranking of Kings, Spy × Family, My Deer Friend Nokotan, and the first seasons of The Ancient Magus Bride and Vinland Saga.")
        
//        addAnime(connection: connection,
//                 name: "Attack on Titan",
//                 studio: "Wit Studio",
//                 synopsis: "Humans fight titans",
//                 premierDate: "2013-04-07",
//                 genre: "Action",
//                 type: .tv,
//                 imageUrl: "http://example.com/aot.jpg",
//                 finalDate: "2013-08-07",
//                 numEpisodes: 25,
//                 score: 8.9)
        addAnimeNameLocale(connection: connection, id: 4, japaneseName: nil, romajiName: "Shingeki no Kyojin")
        
        getAllTablesData(connection: connection)
        
        
        anyTextQuery(connection: connection, query: "select * from anime;")
        
        addCharacter(connection: connection, name: "Test_char_name", id: 6, description: "some_desc")
        let updates = ["name": "ATAKAAAAAAAAAAA NA TITANOV", "score": "10"]
        
        updateByPrimaryKey(connection: connection, tableName: "anime", primaryKeyColumn: "id", primaryKeyValue: "6", updates: updates)
        
    }
    
    
    private func getConnectionToDb() -> Connection? {
        do {
            var configuration = PostgresClientKit.ConnectionConfiguration()
            configuration.host = config.host
            configuration.port = config.port
            configuration.database = config.database
            configuration.user = config.user
            configuration.credential = .scramSHA256(password: config.password)
            configuration.ssl = false // Отключение SSL
            
            let connection = try PostgresClientKit.Connection(configuration: configuration)
            return connection
            
        }
        catch {
            print("Connection error: \(error)")
            return nil
        }
        
    }
    
    private func anyTextQuery(connection: Connection, query: String) {
        do {
            
            // Выполнение запроса
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
    
    private func addGenre(connection: Connection, name: String, description: String) {
        do {

            // Формируем запрос CALL с параметрами
            let query = """
            CALL add_genre(
                $1, $2
            )
            """

            let statement = try connection.prepareStatement(text: query)
            defer { statement.close() }

            // Выполняем запрос с передачей параметров
            try statement.execute(parameterValues: [
                name,
                description
            ])

            print("Процедура успешно вызвана.")

        } catch {
            print(error)
        }
    }
    
    private func addStudio(connection: Connection, name: String, description: String) {
        do {

            let query = """
            CALL add_studio(
                $1, $2
            )
            """

            let statement = try connection.prepareStatement(text: query)
            defer { statement.close() }

            try statement.execute(parameterValues: [
                name,
                description
            ])

            print("Процедура успешно вызвана.")

        } catch {
            print(error)
        }
    }
    
    private func getAllTablesData(connection: Connection) {
        do {
            let query = "SELECT * FROM get_all_tables_data();"

            let statement = try connection.prepareStatement(text: query)
            defer { statement.close() }

            let cursor = try statement.execute()
            
            // Обработка результата
                for row in cursor {
                    let columns = try row.get().columns
                    let tableName = try columns[0].postgresValue.string() // Имя таблицы
                    let rowData = try columns[1].postgresValue.string()

                    print("Table Name: \(tableName)")
                    //print("Row Data: \(rowData)")
                    if let jsonData = rowData.data(using: .utf8),
                       let jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: []),
                       let jsonDict = jsonObject as? [String: Any] {
                        print("Parsed JSON Data: \(jsonDict)")
                    }
                    else {
                        print("Failed to parse JSON for table: \(tableName)")
                    }
                }
            
            print("Процедура успешно вызвана.")

        } catch {
            print(error)
        }
    }
    
    private func addAnime(connection: Connection, name: String, studio: String, synopsis: String, premierDate: String, genre: String, type: AnimeType, imageUrl: String, finalDate: String, numEpisodes: Int = 0, score: Double = 0.0) {
        
        do {

            let query = """
            CALL add_anime(
                $1, $2, $3, $4, $5, $6::anime_type, $7, $8, $9, $10
            )
            """

            let statement = try connection.prepareStatement(text: query)
            defer { statement.close() }

            try statement.execute(parameterValues: [
                name,
                studio,
                synopsis,
                premierDate,
                genre,
                type.rawValue,
                imageUrl,
                finalDate,
                numEpisodes,
                score
            ])

            print("Процедура успешно вызвана.")

        } catch {
            print(error)
        }
    }
    
    private func addAnimeNameLocale(connection: Connection, id: Int, japaneseName: String?, romajiName: String?) {
        do {

            let query = """
            CALL add_anime_name_locale(
                $1, $2, $3
            )
            """

            let statement = try connection.prepareStatement(text: query)
            defer { statement.close() }

            try statement.execute(parameterValues: [
                id,
                japaneseName,
                romajiName
            ])

            print("Процедура успешно вызвана.")

        } catch {
            print(error)
        }
    }
    
    private func addCharacter(connection: Connection, name: String, id: Int, description: String?) {
        do {

            let query = """
            CALL add_character(
                $1, $2, $3
            )
            """

            let statement = try connection.prepareStatement(text: query)
            defer { statement.close() }

            try statement.execute(parameterValues: [
                name,
                id,
                description
            ])

            print("Процедура успешно вызвана.")

        } catch {
            print(error)
        }
    }
    
    private func updateByPrimaryKey(
        connection: Connection,
        tableName: String,
        primaryKeyColumn: String,
        primaryKeyValue: String,
        updates: [String: String]
    ) {
        do {
            let jsonUpdates = try JSONSerialization.data(withJSONObject: updates, options: [])
            guard let jsonUpdatesString = String(data: jsonUpdates, encoding: .utf8) else {
                print("Ошибка преобразования обновлений в строку JSON.")
                return
            }

            let query = """
            CALL update_by_pk(
                $1, $2, $3, $4
            )
            """

            let statement = try connection.prepareStatement(text: query)
            defer { statement.close() }

            try statement.execute(parameterValues: [
                tableName,
                primaryKeyColumn,
                primaryKeyValue,
                jsonUpdatesString
            ])

            print("Процедура update_by_pk успешно вызвана.")
        } catch {
            print("Ошибка выполнения процедуры: \(error)")
        }
    }
    

}

