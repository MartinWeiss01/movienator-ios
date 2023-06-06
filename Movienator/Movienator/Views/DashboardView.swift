//
//  DashboardView.swift
//  Movienator
//
//  Created by Martin Weiss on 10.05.2023.
//

import SwiftUI

struct DashboardView: View {
    @StateObject var movieViewModel: MovieViewModel
    @FetchRequest(sortDescriptors: []) var movies: FetchedResults<Movie>
    
    @State var searchTitle: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(content: {
                        TextField("", text: $searchTitle)
                    }, header: {
                        Text("Find a Movie/TV series")
                    }, footer: {
                        NavigationLink(destination: SearchTitleView(movieViewModel: movieViewModel, title: searchTitle)) {
                            Text("Search")
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 8)
                                .foregroundColor(.blue)
                        }
                        .disabled(searchTitle.isEmpty)
                        .onTapGesture {
                            movieViewModel.isSearching = true
                        }
                    })
                }
                
                Text("Your Watchlist")
                ScrollView(.horizontal) {
                    LazyHStack {
                        ForEach(movieViewModel.watchlistItems) { movie in
                            Text("\(movie.title)")
                        }
                    }
                }
                
                Text("Your Watched list")
                ScrollView(.horizontal) {
                    LazyHStack {
                        ForEach(movieViewModel.watchedListItems) { movie in
                            Text("\(movie.title)")
                        }
                    }
                }
            }
            .onAppear() {
                movieViewModel.fetchItems(movies: movies)
            }
            .navigationTitle("Movienator")
        }
    }
}

/*
struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
*/
