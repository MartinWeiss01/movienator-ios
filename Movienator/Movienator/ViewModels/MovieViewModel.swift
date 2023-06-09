//
//  MovieViewModel.swift
//  Movienator
//
//  Created by Martin Weiss on 27.04.2023.
//

import Foundation
import CoreData
import SwiftUI

@MainActor //main thread
class MovieViewModel: ObservableObject {
    private let apiManager = APIManager()
    
    @Published var isSearching: Bool = false
    @Published var searchItems: [SearchResultDetail] = []
    @Published var selectedSearchItem: SearchResultDetail?
    
    @Published var movieItems: [MovieItem] = []
    @Published var watchlistItems: [MovieItem] = []
    @Published var watchedListItems: [MovieItem] = []
    
    var moc: NSManagedObjectContext
    init(moc: NSManagedObjectContext) {
        self.moc = moc
    }
    
    func selectSearchItem(id: Int64) {
        selectedSearchItem = searchItems.first(where: { $0.id == id })
    }
    
    private func getLibraryItem(with id: UUID) -> Movie? {
        let request = Movie.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id.description)
        guard let items = try? moc.fetch(request) else {
            return nil
        }
        
        return items.first
    }
    
    func removeLibraryItem(id: UUID) {
        if let deletedItem = getLibraryItem(with: id) {
            moc.delete(deletedItem)
            save()
            
            movieItems.removeAll(where: { $0.id == id })
            watchlistItems.removeAll(where: { $0.id == id })
            watchedListItems.removeAll(where: { $0.id == id })
        }
    }
    
    func addLibraryItem(item: MovieItem) {
        let movie = Movie(context: moc)
        movie.id = item.id
        movie.title = item.title
        movie.tmdb = item.tmdb
        movie.type = item.type.rawValue
        movie.watchState = item.watchState.rawValue
        movie.details = item.details
        movie.rating = item.rating
        movie.poster = item.posterAssetName.pngData()
        movie.backdrop = item.backdropAssetName.pngData()
        
        save()
        movieItems.append(item)
    }
    
    func save() {
        if moc.hasChanges {
            do {
                try moc.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchItems(movies: FetchedResults<Movie>) {
        movieItems = movies.map {
            return MovieItem(
                id: $0.id ?? UUID(),
                title: $0.title ?? "Unknown title",
                tmdb: $0.tmdb,
                type: ItemType(rawValue: $0.type) ?? ItemType.Unknown,
                watchState: WatchState(rawValue: $0.watchState) ?? WatchState.Unknown,
                details: $0.details ?? "No overview available",
                rating: $0.rating,
                posterAssetName: UIImage(data: $0.poster ?? Data()) ?? UIImage(),
                backdropAssetName: UIImage(data: $0.backdrop ?? Data()) ?? UIImage()
            )
        }
        
        watchlistItems = movieItems.filter { $0.watchState == .WantToWatch }
        watchedListItems = movieItems.filter { $0.watchState == .Watched }
    }
    
    func search(query: String) async {
        isSearching = true
        
        defer {
            isSearching = false
        }
        
        let trimmedQuery = query.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedQuery.isEmpty else {
            return
        }
        
        do {
            let movies = try await apiManager.searchMovie(query: trimmedQuery)
            searchItems = movies
        } catch {
            print(error)
        }
        
    }
    /*
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
     */
}
