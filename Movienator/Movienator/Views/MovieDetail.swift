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
    @State var itemType: ItemType = .Movie
    
    @State private var posterImage: UIImage = UIImage()
    @State private var backdropImage: UIImage = UIImage()
    let offset: CGFloat = -100
    
    var body: some View {
        NavigationView {
            if let currentItem = movieViewModel.selectedSearchItem {
                
                ScrollView {
                    AsyncImage(url: currentItem.getBackdropURL) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        Color.gray
                    }
                    .frame(width: UIScreen.main.bounds.width)
                    .frame(minHeight: 186)
                    .onAppear {
                        Task {
                            if let backdropData = try? Data(contentsOf: currentItem.getBackdropURL) {
                                backdropImage = UIImage(data: backdropData) ?? UIImage()
                            }
                        }
                    }
                    
                    
                    AsyncImage(url: currentItem.getPosterURL) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 250)
                            .shadow(radius: 20)
                            .offset(y: offset)
                            .zIndex(1)
                    } placeholder: {
                        Color.gray
                            .shadow(radius: 20)
                            .offset(y: offset)
                            .zIndex(1)
                            .frame(width: 134, height: 201)
                    }
                    .frame(width: 250, height: 250)
                    .onAppear {
                        Task {
                            if let posterData = try? Data(contentsOf: currentItem.getPosterURL) {
                                posterImage = UIImage(data: posterData) ?? UIImage()
                            }
                        }
                    }
                    
                    VStack {
                        Text(currentItem.title)
                            .font(.title)
                            .multilineTextAlignment(.center)
                        
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            Text("\(String(format: "%.1f", currentItem.voteAverage))/10")
                        }
                        
                        HStack {
                            
                            if let libraryItem = movieViewModel.movieItems.first(where: { $0.tmdb == currentItem.id}) {
                                Button("Remove from Your Library") {
                                    movieViewModel.removeLibraryItem(id: libraryItem.id)
                                }
                                .buttonStyle(.bordered)
                                
                            } else {
                                let genresNames = GenreUtils.getGenreNamesFromIds(genreIds: currentItem.genreIds)
                                Button("Add to Watchlist") {
                                    let item: MovieItem = MovieItem(
                                        title: currentItem.title,
                                        tmdb: currentItem.id,
                                        type: itemType,
                                        watchState: .WantToWatch,
                                        details: currentItem.overview,
                                        rating: currentItem.voteAverage,
                                        posterAssetName: posterImage,
                                        backdropAssetName: backdropImage,
                                        releaseDate: currentItem.releaseDate ?? "N/A",
                                        added: Date(),
                                        genres: genresNames
                                    )
                                    movieViewModel.addLibraryItem(item: item)
                                }
                                .buttonStyle(.borderedProminent)
                                
                                Button("Already watched") {
                                    let item: MovieItem = MovieItem(
                                        title: currentItem.title,
                                        tmdb: currentItem.id,
                                        type: itemType,
                                        watchState: .Watched,
                                        details: currentItem.overview,
                                        rating: currentItem.voteAverage,
                                        posterAssetName: posterImage,
                                        backdropAssetName: backdropImage,
                                        releaseDate: currentItem.releaseDate ?? "N/A",
                                        added: Date(),
                                        genres: genresNames
                                    )
                                    movieViewModel.addLibraryItem(item: item)
                                }
                                .buttonStyle(.bordered)
                            }
                        }
                        
                        VStack {
                            VStack(alignment: .leading) {
                                Text("Release")
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(.leading)
                                Text(currentItem.releaseYear)
                                    .multilineTextAlignment(.leading)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Spacer()
                            
                            VStack(alignment: .leading) {
                                Text("Genre")
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(.leading)
                                Text(GenreUtils.getGenreString(genreIds: currentItem.genreIds))
                                    .multilineTextAlignment(.leading)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Spacer()
                            
                            VStack(alignment: .leading) {
                                Text("Overview")
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(.leading)
                                Text(currentItem.overview)
                                    .multilineTextAlignment(.leading)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding(.top, 24)
                    }
                    .padding(.horizontal, 12)
                    .offset(y: offset)
                }
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
