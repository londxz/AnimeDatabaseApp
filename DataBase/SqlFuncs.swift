//
//  SqlFuncs.swift
//  DatabaseAnimeApp
//
//  Created by Родион Холодов on 06.12.2024.
//

import PostgresClientKit
import Foundation


//MARK: - connect + random query
func getConnectionToDb() -> Connection? {
    
    let config = PostgresConfig.shared
    
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

func anyTextQuery(connection: Connection, query: String) {
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

//MARK: - add data

func addGenre(connection: Connection, name: String, description: String) {
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

func addStudio(connection: Connection, name: String, description: String) {
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

func addAnime(connection: Connection, name: String, studio: String, synopsis: String, premierDate: String, genre: String, type: AnimeType, status: AnimeStatus, imageUrl: String, finalDate: String, numEpisodes: Int = 0, score: Double = 0.0) {
    
    do {

        let query = """
        CALL add_anime(
            $1, $2, $3, $4, $5, $6::anime_type, $7::anime_status, $8, $9, $10, $11
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
            status.rawValue,
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

func addAnimeNameLocale(connection: Connection, id: Int, japaneseName: String?, romajiName: String?) {
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

func addCharacter(connection: Connection, name: String, id: Int, description: String?) {
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

//MARK: - update data

func updateByPrimaryKey(connection: Connection, tableName: String, primaryKeyColumn: String, primaryKeyValue: String, updates: [String: String]
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

//MARK: - work with data

func getAllTablesData(connection: Connection) {
    do {
        let query = "SELECT * FROM get_all_tables_data();"

        let statement = try connection.prepareStatement(text: query)
        defer { statement.close() }

        let cursor = try statement.execute()
        
        // Обработка результата
            for row in cursor {
                
                let columns = try row.get().columns
                let tableName = try columns[0].postgresValue.string()
                let rowData = try columns[1].postgresValue.string()
                print("Table Name: \(tableName)")
                
                if let jsonData = rowData.data(using: .utf8),
                   let jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: []),
                   let jsonDict = jsonObject as? [String: Any] {
                    print("Parsed JSON Data: \(jsonDict)")
                }
                else {
                    print("Failed to parse JSON")
                }
            }
        
        print("Процедура успешно вызвана.")

    } catch {
        print(error)
    }
}

func searchAnimeByEnglishName(connection: Connection, englishName: String) {
    do {
        let query = """
        SELECT * FROM search_anime_by_english_name(
            $1
        )
        """

        let statement = try connection.prepareStatement(text: query)
        defer { statement.close() }

        let cursor = try statement.execute(parameterValues: [
            englishName
        ])
        
        // Обработка результата
        for row in cursor {
            let columns = try row.get().columns
            let rowData = try columns[0].postgresValue.string()
            if let jsonData = rowData.data(using: .utf8),
            let jsonArray = try? JSONSerialization.jsonObject(with: jsonData,options: []) as? [[String: Any]] {
                
                print(jsonArray)
                
//                    for anime in jsonArray {
//                        if let id = anime["id"] as? Int,
//                            let name = anime["name"] as? String,
//                            let studio = anime["studio"] as? String,
//                            let synopsis = anime["synopsis"] as? String? {
//                            print("""
//                            ID: \(id)
//                            Name: \(name)
//                            Studio: \(studio)
//                            Synopsis: \(synopsis ?? "N/A")
//                            """)
//                        } else {
//                            print("Missing or invalid fields in anime JSON object:\(anime)")
//                        }
//                    }
            } else {
                print("Failed to parse JSON array from the result.")
            }
        }
    } catch {
        print("Ошибка выполнения процедуры: \(error)")
    }
}

func getGenreData(connection: Connection, numRows: Int, offset: Int = 0, sortCol: String = "name", sortDirection: String = "ASC", searchTerm: String? = nil) {
    
    do {
        // Подготовка SQL-запроса к функции
        let query = """
        SELECT * FROM get_genre_data($1, $2, $3, $4, $5)
        """
        
        var parameters: [PostgresValueConvertible] = [
            numRows,
            offset,
            sortCol,
            sortDirection
        ]
        
        if let term = searchTerm {
            parameters.append("%\(term)%")
        } else {
            parameters.append(nil as String?)
        }
        
        let statement = try connection.prepareStatement(text: query)
        defer { statement.close() }
        
        // Выполнение запроса
        let cursor = try statement.execute(parameterValues: parameters)
        defer { cursor.close() }
        
        // Обработка результата
        for row in cursor {
            let columns = try row.get().columns
            guard columns.count == 2 else {
                print("Unexpected number of columns in result")
                continue
            }
            
            if let name = try? columns[0].postgresValue.string(),
               let description = try? columns[1].postgresValue.string() {
                print("Name: \(name), Description: \(description)")
            }
        }
        
        print("Процедура успешно выполнена.")
    } catch {
        print("Ошибка при вызове процедуры getGenreData: \(error)")
    }
}

func getStudioData(connection: Connection, numRows: Int, offset: Int = 0, sortCol: String = "name", sortDirection: String = "ASC", searchTerm: String? = nil) {
    
    do {
        // Подготовка SQL-запроса к функции
        let query = """
        SELECT * FROM get_studio_data($1, $2, $3, $4, $5)
        """
        
        var parameters: [PostgresValueConvertible] = [
            numRows,
            offset,
            sortCol,
            sortDirection
        ]
        
        if let term = searchTerm {
            parameters.append("%\(term)%")
        } else {
            parameters.append(nil as String?)
        }
        
        let statement = try connection.prepareStatement(text: query)
        defer { statement.close() }
        
        // Выполнение запроса
        let cursor = try statement.execute(parameterValues: parameters)
        defer { cursor.close() }
        
        // Обработка результата
        for row in cursor {
            let columns = try row.get().columns
            guard columns.count == 2 else {
                print("Unexpected number of columns in result")
                continue
            }
            
            if let name = try? columns[0].postgresValue.string(),
               let description = try? columns[1].postgresValue.string() {
                print("Name: \(name), Description: \(description)")
            }
        }
        
        print("Процедура успешно выполнена.")
    } catch {
        print("Ошибка при вызове процедуры getStudioData: \(error)")
    }
}

func getAnimeData(connection: Connection, numRows: Int, offset: Int = 0, sortCol: String = "name", sortDirection: String = "ASC") {
    
    do {
        // Подготовка SQL-запроса к функции
        let query = """
        SELECT * FROM get_anime_data($1, $2, $3, $4)
        """
        
        let parameters: [PostgresValueConvertible] = [
            numRows,
            offset,
            sortCol,
            sortDirection
        ]
        
        let statement = try connection.prepareStatement(text: query)
        defer { statement.close() }
        
        // Выполнение запроса
        let cursor = try statement.execute(parameterValues: parameters)
        defer { cursor.close() }
        
        // Обработка результата
        for row in cursor {
            let columns = try row.get().columns
            guard columns.count == 13 else {
                print("Unexpected number of columns in result")
                continue
            }
            
            if let id = try? columns[0].postgresValue.int(),
               let name = try? columns[1].postgresValue.string(),
               let studio = try? columns[2].postgresValue.string(),
               let synopsis = try? columns[3].postgresValue.string(),
               let image = try? columns[4].postgresValue.string(),
               let premierDate = try? columns[5].postgresValue.date(),
               let finalDate = try? columns[6].postgresValue.date(),
               let numEpisodes = try? columns[7].postgresValue.int(),
               let score = try? columns[8].postgresValue.double(),
               let genre = try? columns[9].postgresValue.string(),
               let type = try? columns[10].postgresValue.string(),
               let status = try? columns[11].postgresValue.string(),
               let updatedAt = try? columns[12].postgresValue.timestamp() {
            
                print("\(id),\(name),\(studio),\(synopsis),\(image),\(premierDate),\(finalDate),\(numEpisodes),\(score),\(genre),\(type),\(status), \(updatedAt)")
            }

        }
        
        print("Процедура успешно выполнена.")
    } catch {
        print("Ошибка при вызове процедуры getAnimeData: \(error)")
    }
}

func getAnimeNameLocaleData(connection: Connection, numRows: Int, offset: Int = 0, sortCol: String = "romaji_name", sortDirection: String = "ASC", searchTerm: String? = nil) {
    
    do {
        // Подготовка SQL-запроса к функции
        let query = """
        SELECT * FROM get_anime_name_locale_data($1, $2, $3, $4, $5)
        """
        
        var parameters: [PostgresValueConvertible] = [
            numRows,
            offset,
            sortCol,
            sortDirection
        ]
        
        if let term = searchTerm {
            parameters.append("%\(term)%")
        } else {
            parameters.append(nil as String?)
        }
        
        let statement = try connection.prepareStatement(text: query)
        defer { statement.close() }
        
        // Выполнение запроса
        let cursor = try statement.execute(parameterValues: parameters)
        defer { cursor.close() }
        
        // Обработка результата
        for row in cursor {
            let columns = try row.get().columns
            guard columns.count == 3 else {
                print("Unexpected number of columns in result")
                continue
            }
            
            if let animeId = try? columns[0].postgresValue.int(),
               let japanName = try? columns[1].postgresValue.string(),
               let romajiName = try? columns[2].postgresValue.string() {
                print("\(animeId),\(japanName),\(romajiName)")
            }
        }
        
        print("Процедура успешно выполнена.")
    } catch {
        print("Ошибка при вызове процедуры getAnimeNameLocaleData: \(error)")
    }
}

func getCharacterData(connection: Connection, numRows: Int, offset: Int = 0, sortCol: String = "name", sortDirection: String = "ASC", searchTerm: String? = nil) {
    
    do {
        // Подготовка SQL-запроса к функции
        let query = """
        SELECT * FROM get_character_data($1, $2, $3, $4, $5)
        """
        
        var parameters: [PostgresValueConvertible] = [
            numRows,
            offset,
            sortCol,
            sortDirection
        ]
        
        if let term = searchTerm {
            parameters.append("%\(term)%")
        } else {
            parameters.append(nil as String?)
        }
        
        let statement = try connection.prepareStatement(text: query)
        defer { statement.close() }
        
        // Выполнение запроса
        let cursor = try statement.execute(parameterValues: parameters)
        defer { cursor.close() }
        
        // Обработка результата
        for row in cursor {
            let columns = try row.get().columns
            guard columns.count == 4 else {
                print("Unexpected number of columns in result")
                continue
            }
            
            if let id = try? columns[0].postgresValue.int(),
               let name = try? columns[1].postgresValue.string(),
               let animeId = try? columns[2].postgresValue.int(),
               let description = try? columns[3].postgresValue.string() {
                print("\(id),\(name),\(animeId),\(description)")
            }
        }
        
        print("Процедура успешно выполнена.")
    } catch {
        print("Ошибка при вызове процедуры getCharacterData: \(error)")
    }
}

//MARK: - delete data

func clearTable(connection: Connection, name: String) {
    do {
        let query = "CALL clear_table($1)"
        
        let statement = try connection.prepareStatement(text: query)
        defer { statement.close() }
        
        try statement.execute(parameterValues: [
            name
        ])
        
        print("Процедура clearTable успешно выполнена")
    } catch {
        print("Ошибка выполнения процедуры clearTable: \(error)")
    }
}

func clearAllTables(connection: Connection) {
    
    do {
        let query = "CALL clear_all_tables()"
        
        let statement = try connection.prepareStatement(text: query)
        defer { statement.close() }
        
        try statement.execute()
        
        print("Процедура clearAllTables успешно вызвана.")
        
    } catch {
        print("Ошибка выполнения процедуры clearAllTables: \(error)")
    }
}

func deleteByPk(connection: Connection, name: String, pkColumn: String, pkValue: String) {
    do {
        let query = """
        CALL delete_by_pk(
            $1, $2, $3
        )
        """

        let statement = try connection.prepareStatement(text: query)
        defer { statement.close() }

        try statement.execute(parameterValues: [
            name,
            pkColumn,
            pkValue
        ])

        print("Процедура deleteByPk успешно вызвана.")
    } catch {
        print("Ошибка выполнения процедуры deleteByPk: \(error)")
    }
}

func deleteCharacterByDescription(connection: Connection, description: String) {
    do {
        let query = """
        CALL delete_character_by_description(
            $1
        )
        """

        let statement = try connection.prepareStatement(text: query)
        defer { statement.close() }

        try statement.execute(parameterValues: [
            description
        ])

        print("Процедура deleteCharacterByDescription успешно вызвана.")
    } catch {
        print("Ошибка выполнения процедуры deleteCharacterByDescription: \(error)")
    }
}

func callTestFuncs() {
    guard let connection = getConnectionToDb() else { return }
    defer { connection.close() }
    
    addGenre(connection: connection, name: "ActioN",
             description: "The action film is a film genre that predominantly features chase sequences, fights, shootouts, explosions, and stunt work.")
    addStudio(connection: connection, name: "Wit Studio",
              description: "Japanese animation studio founded on June 1, 2012, by producers at Production I.G as a subsidiary of IG Port. It is headquartered in Musashino, Tokyo, with Production I.G producer George Wada as president and Tetsuya Nakatake, also a producer at Production I.G, as a director of the studio. The studio gained notability for producing Attack on Titan (the first three seasons), Great Pretender, Ranking of Kings, Spy × Family, My Deer Friend Nokotan, and the first seasons of The Ancient Magus Bride and Vinland Saga.")
    
    addAnime(connection: connection,
             name: "Attack on Titan",
             studio: "Wit Studio",
             synopsis: "Humans fight titans",
             premierDate: "2013-04-07",
             genre: "Action",
             type: .tv,
             status: .finished,
             imageUrl: "http://example.com/aot.jpg",
             finalDate: "2013-08-07",
             numEpisodes: 25,
             score: 8.9)
    
    addAnimeNameLocale(connection: connection, id: 4, japaneseName: nil, romajiName: "Shingeki no Kyojin")
    
    getAllTablesData(connection: connection)
    
    
    anyTextQuery(connection: connection, query: "select * from anime;")
    
    addCharacter(connection: connection, name: "Test_char_name2", id: 31, description: "no_delete_me")
    
    updateByPrimaryKey(connection: connection, tableName: "anime", primaryKeyColumn: "id", primaryKeyValue: "18", updates: ["name": "DXDDDDD", "score": "10"])
    
    searchAnimeByEnglishName(connection: connection, englishName: "DXD")
    
    //clearTable(connection: connection, name: "anime")
    
    //clearAllTables(connection: connection)
    
    deleteByPk(connection: connection, name: "anime", pkColumn: "id", pkValue: "19")
    
    deleteCharacterByDescription(connection: connection, description: "no_delete_me")
}
