//
//  LibraryDetail.swift
//  Movienator
//
//  Created by Martin Weiss on 14.06.2023.
//

import SwiftUI

struct LibraryDetail: View {
    @StateObject var movieViewModel: MovieViewModel
    @Binding var detailPresented: Bool

    @State private var posterImage: UIImage = UIImage()
    @State private var backdropImage: UIImage = UIImage()
    let offset: CGFloat = -100
    
    @State var removedItem: Bool = false
    @State var movieItem: MovieItem? = nil
    
    var body: some View {
        NavigationView {
            if let currentItem = movieViewModel.selectedLibraryItem {
                
                ScrollView {
                    if currentItem.backdropAssetName.pngData() != UIImage().pngData() {
                        Image(uiImage: currentItem.backdropAssetName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width)
                            .frame(minHeight: 186)
                    } else {
                        Color.gray
                            .frame(width: UIScreen.main.bounds.width, height: 186)
                    }
                    Image(uiImage: currentItem.posterAssetName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 250)
                        .shadow(radius: 20)
                        .offset(y: offset)
                        .zIndex(1)
                        .frame(width: 250, height: 250)
                    
                    VStack {
                        Text(currentItem.title)
                            .font(.title)
                            .multilineTextAlignment(.center)

                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            Text("\(String(format: "%.1f", currentItem.rating))/10")
                        }
                        
                        HStack {
                            
                            if !removedItem {
                                Button("Remove from Your Library") {
                                    movieItem = currentItem
                                    movieViewModel.removeLibraryItem(id: currentItem.id)
                                    posterImage = currentItem.posterAssetName
                                    backdropImage = currentItem.backdropAssetName
                                    removedItem = true
                                }
                                .buttonStyle(.bordered)

                            } else {
                                Button("Add to Watchlist") {
                                    let item: MovieItem = MovieItem(
                                        title: movieItem!.title,
                                        tmdb: movieItem!.tmdb,
                                        type: movieItem!.type,
                                        watchState: .WantToWatch,
                                        details: movieItem!.details,
                                        rating: movieItem!.rating,
                                        posterAssetName: posterImage,
                                        backdropAssetName: backdropImage,
                                        releaseDate: movieItem!.releaseDate,
                                        added: Date()
                                    )
                                    movieViewModel.addLibraryItem(item: item)
                                    removedItem = false
                                }
                                    .buttonStyle(.borderedProminent)
                                
                                Button("Already watched") {
                                    let item: MovieItem = MovieItem(
                                        title: movieItem!.title,
                                        tmdb: movieItem!.tmdb,
                                        type: movieItem!.type,
                                        watchState: .Watched,
                                        details: movieItem!.details,
                                        rating: movieItem!.rating,
                                        posterAssetName: posterImage,
                                        backdropAssetName: backdropImage,
                                        releaseDate: movieItem!.releaseDate,
                                        added: Date()
                                    )
                                    movieViewModel.addLibraryItem(item: item)
                                    removedItem = false
                                }
                                    .buttonStyle(.bordered)
                            }
                        }
                        
                        VStack {
                            VStack(alignment: .leading) {
                                Text("Type")
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(.leading)
                                Text(currentItem.type.name)
                                    .multilineTextAlignment(.leading)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                            Spacer()
                            
                            
                            VStack(alignment: .leading) {
                                Text("Release")
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(.leading)
                                Text(currentItem.releaseDate)
                                    .multilineTextAlignment(.leading)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                            Spacer()
                            
                            VStack(alignment: .leading) {
                                Text("Overview")
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(.leading)
                                Text(currentItem.details)
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
