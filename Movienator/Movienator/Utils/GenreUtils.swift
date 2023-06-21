//
//  GenreUtils.swift
//  Movienator
//
//  Created by Martin Weiss on 21.06.2023.
//

import Foundation

class GenreUtils {
    static func getGenreNamesFromIds(genreIds: [Int64]?) -> [String] {
        if let genresList = genreIds {
            let genreNames = genresList.compactMap { id in
                GenreList(rawValue: Int(id))?.name
            }
            return genreNames
        } else {
            return []
        }
    }
    
    static func getGenreString(genreIds: [Int64]?) -> String {
        let genreName = getGenreNamesFromIds(genreIds: genreIds)
        let genreConcat = genreName.joined(separator: ", ")
        return genreConcat
    }
    
    static func getGenreString(genres: [String]) -> String {
        let genreConcat = genres.joined(separator: ", ")
        return genreConcat
    }
}
