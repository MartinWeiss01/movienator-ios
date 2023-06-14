//
//  MovieItem.swift
//  Movienator
//
//  Created by Martin Weiss on 27.04.2023.
//

import SwiftUI

struct MovieItem: Identifiable {
    var id = UUID()
    var title: String
    var tmdb: Int64
    var type: ItemType
    var watchState: WatchState
    var details: String
    var rating: Double
    var posterAssetName: UIImage
    var backdropAssetName: UIImage
    var releaseDate: String
    var added: Date
}

enum ItemType: Int16, CaseIterable, Identifiable {
    var id: Self { self } //because of Identifiable & CaseIterable
    
    case Unknown = 1
    case Movie = 2
    case TV = 3
    
    var name: String {
        get { return String(describing: self) }
    }
    
    var navigationTitle: String {
        switch self {
        case .Unknown:
            return "Results"
        case .Movie:
            return "Found movies"
        case .TV:
            return "Found TV series"
        }
    }
}

enum WatchState: Int16, CaseIterable, Identifiable {
    var id: Self { self }
    
    case Unknown = 1
    case WantToWatch = 2
    case Watched = 3
    
    var name: String {
        get { return String(describing: self) }
    }
}
