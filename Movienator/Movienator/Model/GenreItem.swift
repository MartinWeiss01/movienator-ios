//
//  GenreItem.swift
//  Movienator
//
//  Created by Martin Weiss on 27.04.2023.
//

import Foundation

struct GenreItem: Identifiable {
    let id: Int16
    var name: String
}

enum GenreList: Int, CaseIterable, Identifiable {
    case adventure = 12
    case fantasy = 14
    case animation = 16
    case drama = 18
    case musical = 22
    case horror = 27
    case action = 28
    case comedy = 35
    case history = 36
    case western = 37
    case thriller = 53
    case crime = 80
    case eastern = 82
    case documentary = 99
    case disaster = 105
    case scienceFiction = 878
    case roadMovie = 1115
    case erotic = 2916
    case mystery = 9648
    case sport = 9805
    case music = 10402
    case holiday = 10595
    case suspense = 10748
    case romance = 10749
    case fanFilm = 10750
    case family = 10751
    case war = 10752
    case filmNoir = 10753
    case neoNoir = 10754
    case short = 10755
    case indie = 10756
    case sportsFilm = 10757
    case sportingEvent = 10758
    case actionAdventure = 10759
    case british = 10760
    case education = 10761
    case kids = 10762
    case news = 10763
    case reality = 10764
    case sciFiFantasy = 10765
    case soap = 10766
    case talk = 10767
    case warPolitics = 10768
    case foreign = 10769
    case tvMovie = 10770
    
    var id: Int { rawValue }
    
    var name: String {
        switch self {
        case .adventure:
            return "Adventure"
        case .fantasy:
            return "Fantasy"
        case .animation:
            return "Animation"
        case .drama:
            return "Drama"
        case .musical:
            return "Musical"
        case .horror:
            return "Horror"
        case .action:
            return "Action"
        case .comedy:
            return "Comedy"
        case .history:
            return "History"
        case .western:
            return "Western"
        case .thriller:
            return "Thriller"
        case .crime:
            return "Crime"
        case .eastern:
            return "Eastern"
        case .documentary:
            return "Documentary"
        case .disaster:
            return "Disaster"
        case .scienceFiction:
            return "Science Fiction"
        case .roadMovie:
            return "Road Movie"
        case .erotic:
            return "Erotic"
        case .mystery:
            return "Mystery"
        case .sport:
            return "Sport"
        case .music:
            return "Music"
        case .holiday:
            return "Holiday"
        case .suspense:
            return "Suspense"
        case .romance:
            return "Romance"
        case .fanFilm:
            return "Fan Film"
        case .family:
            return "Family"
        case .war:
            return "War"
        case .filmNoir:
            return "Film Noir"
        case .neoNoir:
            return "Neo-noir"
        case .short:
            return "Short"
        case .indie:
            return "Indie"
        case .sportsFilm:
            return "Sports Film"
        case .sportingEvent:
            return "Sporting Event"
        case .actionAdventure:
            return "Action & Adventure"
        case .british:
            return "British"
        case .education:
            return "Education"
        case .kids:
            return "Kids"
        case .news:
            return "News"
        case .reality:
            return "Reality"
        case .sciFiFantasy:
            return "Sci-Fi & Fantasy"
        case .soap:
            return "Soap"
        case .talk:
            return "Talk"
        case .warPolitics:
            return "War & Politics"
        case .foreign:
            return "Foreign"
        case .tvMovie:
            return "TV Movie"
        }
    }
}
