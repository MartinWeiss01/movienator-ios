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
                          }
                          .frame(width: 250, height: 250)
                    
                    VStack {
                        Text(currentItem.title)
                            .font(.title)

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
                                
                                Button("Already watched") {
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
