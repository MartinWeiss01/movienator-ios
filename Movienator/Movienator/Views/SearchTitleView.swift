//
//  SearchTitleView.swift
//  Movienator
//
//  Created by Martin Weiss on 10.05.2023.
//

import SwiftUI

@MainActor
struct SearchTitleView: View {
    @StateObject var movieViewModel: MovieViewModel
    @State var title: String

    @State private var detailPresented: Bool = false
    
    var body: some View {
        VStack {
            if (movieViewModel.isSearching) {
                ProgressView()
            } else {
                if(movieViewModel.searchItems.isEmpty) {
                    Text("No matches")
                } else {
                    List(movieViewModel.searchItems) { movie in
                        if(movie.releaseYear != "N/A" && movie.posterPath != nil) {
                            HStack(alignment: .top) {
                                AsyncImage(url: movie.getPosterURL) { phase in
                                    switch phase {
                                    case .empty:
                                        // Placeholder
                                        MoviePosterPlaceholder()
                                    case .success(let image):
                                        // Obrázek načtený úspěšně
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 100)
                                    case .failure:
                                        // Chyba při načítání obrázku
                                        MoviePosterPlaceholder()
                                    @unknown default:
                                        // Neznámý stav
                                        EmptyView()
                                    }
                                }
                                
                                VStack(alignment: .leading) {
                                    Text("\(movie.title)")
                                        .fontWeight(.bold)
                                    Text("\(movie.releaseYear)")
                                    
                                    Spacer()
                                    
                                    Button("Details") {}
                                }.padding(.all)
                            }
                            .padding(.vertical)
                            .onTapGesture {
                                movieViewModel.selectSearchItem(id: movie.id)
                                detailPresented.toggle()
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            Task {
                await movieViewModel.search(query: title)
            }
        }
        .sheet(isPresented: $detailPresented) {
            SearchMovieDetail(
                movieViewModel: movieViewModel,
                detailPresented: $detailPresented
            )
        }
        .navigationTitle("Found movies")
    }
}
/*
struct SearchTitleView_Previews: PreviewProvider {
    static var previews: some View {
        SearchTitleView(title: "Fast and Furious")
    }
}
*/
