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
    private let apiManager = APIManager()
    
    @Published var isSearching: Bool = false
    @Published var searchItems: [MovieItem] = []
    
    @Published var movieItems: [MovieItem] = []
    
    var moc: NSManagedObjectContext
    init(moc: NSManagedObjectContext) {
        self.moc = moc
    }
    
    func convertSearchResponseToMovieItem(response: SearchMovieResponseDTO) -> [MovieItem]? {
        let coordinatesSplit = response.results.

        let latitude = Double(coordinatesSplit.first ?? "")
        let longitude = Double(coordinatesSplit.last ?? "")

        guard
            let latitude,
            let longitude
        else {
            return nil
        }
        
        return MapItem(
            name: "IP \(response.region)",
            style: .Modern,
            imageAssetName: UIImage(),
            coordinates: CLLocationCoordinate2D(
                latitude: latitude,
                longitude: longitude
            ),
            locationType: .House
        )
    }
    
    func searchMovies(title: String) async throws {
        isSearching = true
        
        defer {
            isSearching = false
        }
        
        let searchMovieResponseDTO: SearchMovieResponseDTO = try await apiManager.request(SearchRouter.movie(title: title))
        
        guard let resultItems = con
    }
}
