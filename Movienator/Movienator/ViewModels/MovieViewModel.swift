//
//  MovieViewModel.swift
//  Movienator
//
//  Created by Martin Weiss on 27.04.2023.
//

import Foundation
import CoreData

@MainActor //main thread
class MovieViewModel: ObservableObject {
    @Published var movieItems: [MovieItem] = []
    
    var moc: NSManagedObjectContext
    init(moc: NSManagedObjectContext) {
        self.moc = moc
    }
    
    
}
