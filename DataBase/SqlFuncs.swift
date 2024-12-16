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
        configuration.user = UserCredentials.login
        configuration.credential = .scramSHA256(password: UserCredentials.password)
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
        
            let statement = try connection.prepareStatement(text: query)
            defer { statement.close() }

            let cursor = try statement.execute()
            defer { cursor.close() }

            for row in cursor {
                let columns = try row.get().columns
                for (index, column) in columns.enumerated() {
                    let value = column.postgresValue
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

        let query = """
        CALL add_genre(
            $1, $2
        )
        """

        let statement = try connection.prepareStatement(text: query)
        defer { statement.close() }

        try statement.execute(parameterValues: [
            name,
            description
        ])
        
        print("Процедура addGenre успешно вызвана")

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

        print("Процедура addStudio успешно вызвана")

    } catch {
        print(error)
    }
}

func addAnime(connection: Connection, name: String, studio: String, synopsis: String, premierDate: String, genre: String, type: AnimeType, status: AnimeStatus, imageUrl: String, finalDate: String, numEpisodes: Int = 0, score: Double = 0.0) {
    
    do {

        let query = """
        CALL add_anime(
            $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11
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

        print("Процедура addAnime успешно вызвана")

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

        print("Процедура addAnimeNameLocale успешно вызвана")

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

        print("Процедура addCharacter успешно вызвана")

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
            print("updateByPrimaryKey: Ошибка преобразования обновлений в строку JSON")
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

        print("Процедура updateByPrimaryKey успешно вызвана")
    } catch {
        print("Ошибка выполнения процедуры updateByPrimaryKey: \(error)")
    }
}

//MARK: - work with data

func getAllTablesData(connection: Connection) -> [String: [Any]]? {
    do {
        var result = [String: [Any]]()
        
        let query = "SELECT * FROM get_all_tables_data();"

        let statement = try connection.prepareStatement(text: query)
        defer { statement.close() }

        let cursor = try statement.execute()

            for row in cursor {
                
                let columns = try row.get().columns
                var tableName = try columns[0].postgresValue.string()
                tableName = tableName.replacingOccurrences(of: "public.", with: "")
                let rowData = try columns[1].postgresValue.string()
                
                switch tableName {
                case "anime":
                    if let jsonData = rowData.data(using: .utf8),
                       let model = try? JSONDecoder().decode(AnimeModel.self, from: jsonData) {
                        result[tableName, default: []].append(model)
                    }
                    else {
                        print("Failed to parse AnimeModel JSON")
                    }
                case "genre":
                    if let jsonData = rowData.data(using: .utf8),
                       let model = try? JSONDecoder().decode(GenreModel.self, from: jsonData) {
                        result[tableName, default: []].append(model)
                    }
                    else {
                        print("Failed to parse GenreModel JSON")
                    }
                case "studio":
                    if let jsonData = rowData.data(using: .utf8),
                       let model = try? JSONDecoder().decode(StudioModel.self, from: jsonData) {
                        result[tableName, default: []].append(model)
                    }
                    else {
                        print("Failed to parse StudioModel JSON")
                    }
                case "anime_name_locale":
                    if let jsonData = rowData.data(using: .utf8),
                       let model = try? JSONDecoder().decode(AnimeNameLocaleModel.self, from: jsonData) {
                        result[tableName, default: []].append(model)
                    }
                    else {
                        print("Failed to parse AnimeNameLocaleModel JSON")
                    }
                case "character":
                    if let jsonData = rowData.data(using: .utf8),
                       let model = try? JSONDecoder().decode(CharacterModel.self, from: jsonData) {
                        result[tableName, default: []].append(model)
                    }
                    else {
                        
                        print("Failed to parse CharacterModel JSON")
                    }
                default: continue
                }
            }
        
        print("Процедура getAllTablesData успешно вызвана")
        return result

    } catch {
        print(error)
    }
    return nil
}

func searchAnimeByEnglishName(connection: Connection, englishName: String) -> [String: [Any]]? {
    do {
        
        var result = [String: [Any]]()
        
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
        
        for row in cursor {
            let columns = try row.get().columns
            let rowData = try columns[0].postgresValue.string()
            
            if let jsonData = rowData.data(using: .utf8),
            let jsonArray = try? JSONSerialization.jsonObject(with: jsonData,options: []) as? [[String: Any]] {
                
                    for anime in jsonArray {
                        if let id = anime["id"] as? Int,
                            let name = anime["name"] as? String,
                            let studio = anime["studio"] as? String,
                            let synopsis = anime["synopsis"] as? String,
                            let imageURL = anime["image_url"] as? String,
                            let premiereDate = anime["premiere_date"] as? String,
                            let finaleDate = anime["finale_date"] as? String,
                            let numEpisodes = anime["num_episodes"] as? Int,
                            let score = anime["score"] as? Double,
                            let genre = anime["genre"] as? String,
                            let type = anime["type"] as? String,
                            let status = anime["status"] as? String,
                            let updatedAt = anime["updated_at"] as? String
                        {
                            let anime = AnimeModel(
                                id: id,
                                name: name,
                                studio: studio,
                                synopsis: synopsis,
                                image_url: imageURL,
                                premiere_date: premiereDate,
                                finale_date: finaleDate,
                                num_episodes: numEpisodes,
                                score: score,
                                genre: genre,
                                type: type,
                                status: status,
                                updated_at: updatedAt
                            )
                            result["anime", default: []].append(anime)
                        } else {
                            print("searchAnimeByEnglishName: Missing or invalid fields in anime JSON object")
                        }
                    }
            } else {
                print("searchAnimeByEnglishName: Failed to parse JSON array from the result.")
            }
        }
        
        print("Процедура searchAnimeByEnglishName успешно вызвана")
        return result
        
    } catch {
        print("Ошибка выполнения процедуры searchAnimeByEnglishName: \(error)")
    }
    
    return nil
}

func getGenreData(connection: Connection, numRows: Int, offset: Int = 0, sortCol: String = "name", sortDirection: String = "ASC", searchTerm: String? = nil) -> [GenreModel]? {
    
    do {
        
        var result = [GenreModel]()
        
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
        
        let cursor = try statement.execute(parameterValues: parameters)
        defer { cursor.close() }
        
        for row in cursor {
            let columns = try row.get().columns
            guard columns.count == 2 else {
                print("getGenreData: Unexpected number of columns in result")
                continue
            }
            
            if let name = try? columns[0].postgresValue.string(),
               let description = try? columns[1].postgresValue.string() {
                let genre = GenreModel(
                    name: name,
                    description: description
                )
                result.append(genre)
            } else {
            print("getGenreData: Failed to parse row data")
            }
        }
    
        print("Процедура getGenreData успешно вызвана.")
        return result
    } catch {
        print("Ошибка при вызове процедуры getGenreData: \(error)")
    }
    
    return nil
}

func getStudioData(connection: Connection, numRows: Int, offset: Int = 0, sortCol: String = "name", sortDirection: String = "ASC", searchTerm: String? = nil) -> [StudioModel]? {
    
    do {
        
        var result = [StudioModel]()
        
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
        
        let cursor = try statement.execute(parameterValues: parameters)
        defer { cursor.close() }
        
        for row in cursor {
            let columns = try row.get().columns
            guard columns.count == 2 else {
                print("getStudioData: Unexpected number of columns in result")
                continue
            }
              
//            if let name = try? columns[0].postgresValue.string(),
//               let description = try? columns[1].postgresValue.string() {
//                let studio = StudioModel(
//                    name: name,
//                    description: description
//                )
//                result.append(studio)
//            } else {
//            print("getStudioData: Failed to parse row data")
//            }
            
            for row in columns {
                let name: String
                if let extractedName = try? columns[0].postgresValue.string() {
                    name = extractedName
                } else {
                    name = "some name"
                }

                let description: String
                if let extractedDescription = try? columns[1].postgresValue.string() {
                    description = extractedDescription
                } else {
                    description = "some description"
                }

                let studio = StudioModel(
                    name: name,
                    description: description
                )
                result.append(studio)
            }
        }
        
        print("Процедура getStudioData успешно вызвана")
        return result
    } catch {
        print("Ошибка при вызове процедуры getStudioData: \(error)")
    }
    
    return nil
}

func getAnimeData(connection: Connection, numRows: Int, offset: Int = 0, sortCol: String = "name", sortDirection: String = "ASC") -> [AnimeModel]? {
    
    do {
        
        var result = [AnimeModel]()
        
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
        
        let cursor = try statement.execute(parameterValues: parameters)
        defer { cursor.close() }
        
        for row in cursor {
            let columns = try row.get().columns
            guard columns.count == 13 else {
                print("getAnimeData: Unexpected number of columns in result")
                continue
            }
            
            if let id = try? columns[0].postgresValue.int(),
               let name = try? columns[1].postgresValue.string(),
               let studio = try? columns[2].postgresValue.string(),
               let synopsis = try? columns[3].postgresValue.string(),
               let imageURL = try? columns[4].postgresValue.string(),
               let premiereDate = try? columns[5].postgresValue.string(),
               let finaleDate = try? columns[6].postgresValue.string(),
               let numEpisodes = try? columns[7].postgresValue.int(),
               let score = try? columns[8].postgresValue.double(),
               let genre = try? columns[9].postgresValue.string(),
               let type = try? columns[10].postgresValue.string(),
               let status = try? columns[11].postgresValue.string(),
               let updatedAt = try? columns[12].postgresValue.string() {

                let anime = AnimeModel(
                    id: id,
                    name: name,
                    studio: studio,
                    synopsis: synopsis,
                    image_url: imageURL,
                    premiere_date: premiereDate,
                    finale_date: finaleDate,
                    num_episodes: numEpisodes,
                    score: score,
                    genre: genre,
                    type: type,
                    status: status,
                    updated_at: updatedAt
                )
                //result["anime", default: []].append(anime)
                result.append(anime)
            } else {
                print("getAnimeData: Failed to parse row data")
            }
        }
        print("Процедура getAnimeData успешно выполнена")
        return result
    } catch {
        print("Ошибка при вызове процедуры getAnimeData: \(error)")
    }
    return nil
}

func getAnimeNameLocaleData(connection: Connection, numRows: Int, offset: Int = 0, sortCol: String = "romaji_name", sortDirection: String = "ASC", searchTerm: String? = nil) -> [AnimeNameLocaleModel]? {
    
    do {
        
        var result = [AnimeNameLocaleModel]()

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
        
        let cursor = try statement.execute(parameterValues: parameters)
        defer { cursor.close() }
        
        for row in cursor {
            let columns = try row.get().columns
            guard columns.count == 3 else {
                print("getAnimeNameLocaleData: Unexpected number of columns in result")
                continue
            }
            
            if let animeId = try? columns[0].postgresValue.int(),
               let japanName = try? columns[1].postgresValue.string(),
               let romajiName = try? columns[2].postgresValue.string() {
                
                let animeNameLocale = AnimeNameLocaleModel(
                    anime_id: animeId,
                    japanese_name: japanName,
                    romaji_name: romajiName
                )
                result.append(animeNameLocale)
            } else {
                print("getAnimeData: Failed to parse row data")
            }
        }
        
        print("Процедура getAnimeNameLocaleData успешно вызвана")
        return result
        
    } catch {
        print("Ошибка при вызове процедуры getAnimeNameLocaleData: \(error)")
    }
    
    return nil
}

func getCharacterData(connection: Connection, numRows: Int, offset: Int = 0, sortCol: String = "name", sortDirection: String = "ASC", searchTerm: String? = nil) -> [CharacterModel]? {
    
    do {
        
        var result = [CharacterModel]()
        
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
        
        let cursor = try statement.execute(parameterValues: parameters)
        defer { cursor.close() }
        
        for row in cursor {
            let columns = try row.get().columns
            guard columns.count == 4 else {
                print("getCharacterData: Unexpected number of columns in result")
                continue
            }
            
//            if let id = try? columns[0].postgresValue.int(),
//               let name = try? columns[1].postgresValue.string(),
//               let animeId = try? columns[2].postgresValue.int(),
//               let description = try? columns[3].postgresValue.string() {
//                
//                let character = CharacterModel(id: id, name: name, anime_id: animeId, description: description)
//                result["character", default: []].append(character)
//            }
            if let id = try? columns[0].postgresValue.int(),
               let name = try? columns[1].postgresValue.string(),
               let animeId = try? columns[2].postgresValue.int(),
               let description = try? columns[3].postgresValue.string() {
                
                let character = CharacterModel(id: id, name: name, anime_id: animeId, description: description)
                result.append(character)
            } else {
                print("getCharacterData: Failed to parse row data")
            }
        }
        
        print("Процедура getCharacterData успешно вызвана.")
        return result
    } catch {
        print("Ошибка при вызове процедуры getCharacterData: \(error)")
    }
    
    return nil
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
    
    anyTextQuery(connection: connection, query: "select * from anime;")
    addStudio(connection: connection, name: "studio add", description: "1 desc")
    addAnime(connection: connection, name: "4Attack on Titan", studio: "Wit Studio", synopsis: "Humans fight titans", premierDate: "2013-04-07", genre: "Action", type: AnimeType.tv, status: .finished, imageUrl: "http://example.com/aot.jpg", finalDate: "2013-08-07", numEpisodes: 25, score: 10)
    addAnimeNameLocale(connection: connection, id: 2, japaneseName: "2進撃の巨人", romajiName: "2Shingeki no Kyojin")
    addCharacter(connection: connection, name: "2Test_Char_Name", id: 2, description: "2some_desc")
    updateByPrimaryKey(connection: connection, tableName: "anime", primaryKeyColumn: "id", primaryKeyValue: "2", updates: ["name": "ATAKA", "score": "10"])
//    searchAnimeByEnglishName(connection: connection, englishName: "ataka")
    deleteByPk(connection: connection, name: "anime", pkColumn: "id", pkValue: "1")
    deleteCharacterByDescription(connection: connection, description: "some_desc")
    clearAllTables(connection: connection)
    
//    getGenreData(connection: connection, numRows: 3)
//    getStudioData(connection: connection, numRows: 3)
//    getAnimeData(connection: connection, numRows: 3)
//    getAnimeNameLocaleData(connection: connection, numRows: 3)
//    getCharacterData(connection: connection, numRows: 3)
}
