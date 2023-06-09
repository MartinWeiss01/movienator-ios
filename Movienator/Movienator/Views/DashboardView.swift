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
            VStack(alignment: .leading) {
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
                
                GroupTitle(title: "Your Watchlist")
                ScrollView(.horizontal) {
                    LazyHStack {
                        Spacer(minLength: 20)
                        ForEach(movieViewModel.watchlistItems) { movie in
                            Image(uiImage: movie.posterAssetName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 125)
                        }
                        Spacer(minLength: 20)
                    }
                }
                
                GroupTitle(title: "Your Watched list")
                ScrollView(.horizontal) {
                    LazyHStack {
                        Spacer(minLength: 20)
                        ForEach(movieViewModel.watchedListItems) { movie in
                            Image(uiImage: movie.posterAssetName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 125)
                        }
                        Spacer(minLength: 20)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
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

struct GroupTitle: View {
    var title: String
    
    var body: some View {
        Text(title)
            .font(.title3)
            .fontWeight(.semibold)
            .multilineTextAlignment(.leading)
            .padding(.horizontal, 24)
            .padding(.top, 24)
    }
}
