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
    @State var itemType: ItemType = .Movie

    @State private var detailPresented: Bool = false
    
    var body: some View {
        VStack {
            if (movieViewModel.isSearching) {
                ProgressView()
            } else {
                if(movieViewModel.searchItems.isEmpty) {
                    EmptyList(text: "No results found")
                } else {
                    List(movieViewModel.searchItems) { movie in
                        if(movie.releaseYear != "N/A" && movie.posterPath != nil) {
                            ListItem(
                                title: movie.title,
                                releaseYear: movie.releaseYear,
                                posterURL: movie.getPosterURL
                            )
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
                await movieViewModel.search(query: title, type: itemType)
            }
        }
        .sheet(isPresented: $detailPresented) {
            SearchMovieDetail(
                movieViewModel: movieViewModel,
                detailPresented: $detailPresented,
                itemType: itemType
            )
        }
        .navigationTitle(itemType.navigationTitle)
    }
}
/*
struct SearchTitleView_Previews: PreviewProvider {
    static var previews: some View {
        SearchTitleView(title: "Fast and Furious")
    }
}
*/
