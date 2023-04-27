//
//  MovieItem.swift
//  Movienator
//
//  Created by Martin Weiss on 27.04.2023.
//

import SwiftUI

struct MovieItem: Identifiable {
    let id = UUID()
    var title: String
    var tmdb: Int16
    var type: ItemType = .Unknown
    var watchState: WatchState = .Unknown
    var details: String
    var rating: Int16
    var posterAssetName: UIImage
    var backdropAssetName: UIImage
    
    
    enum ItemType: Int16, CaseIterable, Identifiable {
        var id: Self { self } //because of Identifiable & CaseIterable
        
        case Unknown = 1
        case Movie = 2
        case TV = 3
        
        var name: String {
            get { return String(describing: self) }
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
}
