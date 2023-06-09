//
//  MovieDetail.swift
//  Movienator
//
//  Created by Martin Weiss on 02.06.2023.
//

import SwiftUI

struct SearchMovieDetail: View {
    @StateObject var movieViewModel: MovieViewModel
    @Binding var detailPresented: Bool

    var body: some View {
        NavigationView {
            if let currentItem = movieViewModel.selectedSearchItem {
                
                ScrollView {
                    VStack {
                        Text(currentItem.title)
                        
                        HStack {
                            Text("NOW: \(currentItem.id)")
                            ForEach(movieViewModel.movieItems) { movie in
                                Text("\(movie.tmdb)")
                            }
                            if(movieViewModel.movieItems.contains(where: { $0.tmdb == currentItem.id})) {

                                //TODO problem with saving currentItem.id
                                Button("Add to Watchlist") {
                                    let item: MovieItem = MovieItem(
                                        title: currentItem.title,
                                        tmdb: currentItem.id,
                                        type: ItemType.Movie,
                                        watchState: .WantToWatch,
                                        details: currentItem.overview,
                                        rating: currentItem.voteAverage,
                                        posterAssetName: UIImage(),
                                        backdropAssetName: UIImage()
                                    )
                                    movieViewModel.addLibraryItem(item: item)
                                }
                                    .buttonStyle(.borderedProminent)
                                
                                Button("Already have seen") {
                                    let item: MovieItem = MovieItem(
                                        title: currentItem.title,
                                        tmdb: currentItem.id,
                                        type: ItemType.Movie,
                                        watchState: .Watched,
                                        details: currentItem.overview,
                                        rating: currentItem.voteAverage,
                                        posterAssetName: UIImage(),
                                        backdropAssetName: UIImage()
                                    )
                                    movieViewModel.addLibraryItem(item: item)
                                }
                                    .buttonStyle(.bordered)
                            } else {
                                Button("Remove from Your Library") {
                                    
                                }
                            }
                        }
                    }
                }
                .navigationTitle("Detail")
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        Button("Back") {
                            detailPresented.toggle()
                        }
                    }
                }
            }
        }
    }
}
