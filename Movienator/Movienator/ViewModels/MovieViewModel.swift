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
    @Published var selectedLibraryItem: MovieItem?
    
    var moc: NSManagedObjectContext
    init(moc: NSManagedObjectContext) {
        self.moc = moc
    }
    
    func selectSearchItem(id: Int64) {
        selectedSearchItem = searchItems.first(where: { $0.id == id })
    }
    
    func selectLibraryItem(id: UUID) {
        selectedLibraryItem = movieItems.first(where: { $0.id == id })
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
        movie.releaseDate = item.releaseDate
        movie.added = Date()
        
        
        save()
        movieItems.append(item)
        switch item.watchState {
            case .WantToWatch:
                watchlistItems.append(item)
            case .Watched:
                watchedListItems.append(item)
            default:
                break
        }
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
                backdropAssetName: UIImage(data: $0.backdrop ?? Data()) ?? UIImage(),
                releaseDate: $0.releaseDate ?? "N/A",
                added: $0.added ?? Date()
            )
        }
        
        watchlistItems = movieItems.filter { $0.watchState == .WantToWatch }
        watchedListItems = movieItems.filter { $0.watchState == .Watched }
    }
    
    func search(query: String, type: ItemType) async {
        isSearching = true
        
        defer {
            isSearching = false
        }
        
        let trimmedQuery = query.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedQuery.isEmpty else {
            return
        }
        
        do {
            switch type {
            case .Movie:
                let movies = try await apiManager.searchMovie(query: trimmedQuery)
                searchItems = movies
            case .TV:
                let tv = try await apiManager.searchTVSeries(query: trimmedQuery)
                searchItems = tv.map { tvResult -> SearchResultDetail in
                    //print(tvResult.first_air_date)
                    return SearchResultDetail(
                        id: tvResult.id,
                        title: tvResult.name,
                        backdropPath: tvResult.backdropPath,
                        posterPath: tvResult.posterPath,
                        overview: tvResult.overview,
                        voteAverage: tvResult.voteAverage,
                        voteCount: tvResult.voteCount,
                        releaseDate: tvResult.firstAirDate,
                        genreIds: tvResult.genreIds
                    )
                }
                //print(searchItems)
            default:
                searchItems = []
            }
        } catch {
            print(error)
        }
    }
    
    func discover(tmdbId: Int64, type: ItemType) async {
        isSearching = true
        
        defer {
            isSearching = false
        }
        
        guard tmdbId > 0 else {
            return
        }
        
        do {
            switch type {
            case .Movie:
                let movies = try await apiManager.discoverMovie(tmdbId: tmdbId)
                searchItems = movies
                print(searchItems)
            case .TV:
                let tv = try await apiManager.discoverTVSeries(tmdbId: tmdbId)
                searchItems = tv.map { tvResult -> SearchResultDetail in
                    //print(tvResult.first_air_date)
                    return SearchResultDetail(
                        id: tvResult.id,
                        title: tvResult.name,
                        backdropPath: tvResult.backdropPath,
                        posterPath: tvResult.posterPath,
                        overview: tvResult.overview,
                        voteAverage: tvResult.voteAverage,
                        voteCount: tvResult.voteCount,
                        releaseDate: tvResult.firstAirDate,
                        genreIds: tvResult.genreIds
                    )
                }
                print(searchItems)
            default:
                searchItems = []
            }
        } catch {
            print(error)
        }
    }
}
