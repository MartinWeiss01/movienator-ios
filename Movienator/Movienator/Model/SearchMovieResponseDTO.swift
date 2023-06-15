//
//  SearchMovieResponseDTO.swift
//  Movienator
//
//  Created by Martin Weiss on 10.05.2023.
//

import Foundation

struct SearchMovieResponseDTO: Decodable {
    let results: [SearchResultDetail]
}

struct SearchTVResponseDTO: Decodable {
    let results: [SearchTVResultDetail]
}

struct SearchResultDetail: Identifiable, Decodable {
    let id: Int64
    let title: String
    let backdropPath: String?
    let posterPath: String?
    let overview: String
    let voteAverage: Double
    let voteCount: Int
    let releaseDate: String?
    let genreIds: [Int64]?
    
    var releaseYear: String {
        guard let releaseDate = self.releaseDate, let date = DateUtils.format.date(from: releaseDate) else {
                    return "N/A"
                }
                return SearchResultDetail.getYear.string(from: date)
    }
    
    static private let getYear: DateFormatter = {
        let date = DateFormatter()
        date.dateFormat = "yyyy"
        return date
    }()
    
    var getPosterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
    }
    
    var getBackdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")")!
    }
}

struct SearchTVResultDetail: Identifiable, Decodable {
    let id: Int64
    let name: String
    let backdropPath: String?
    let posterPath: String?
    let overview: String
    let voteAverage: Double
    let voteCount: Int
    let firstAirDate: String?
    let genreIds: [Int64]?
    
    var releaseYear: String {
        guard let releaseDate = self.firstAirDate, let date = DateUtils.format.date(from: releaseDate) else {
                    return "N/A"
                }
                return SearchTVResultDetail.getYear.string(from: date)
    }
    
    static private let getYear: DateFormatter = {
        let date = DateFormatter()
        date.dateFormat = "yyyy"
        return date
    }()
    
    var getPosterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
    }
    
    var getBackdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")")!
    }
}

