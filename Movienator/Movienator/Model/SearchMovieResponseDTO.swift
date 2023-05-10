//
//  SearchMovieResponseDTO.swift
//  Movienator
//
//  Created by Martin Weiss on 10.05.2023.
//

import Foundation

struct SearchMovieResponseDTO: Decodable {
    let results: [ResultDetail]
}

struct ResultDetail: Decodable {
    let posterPath: String?
    let adult: Bool
    let overview, releaseDate: String
    let genreIDS: [Int]
    let id: Int
    let title: String
    let backdropPath: String?
    let voteAverage: Double
}
