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
    @State private var selectedType: ItemType = .Movie
    
    var body: some View {
        NavigationView {
            ScrollView {

                VStack(alignment: .leading) {
                    VStack {
                        Section(content: {
                            Picker(selection: $selectedType, label: Text("Type")) {
                                ForEach(ItemType.allCases.filter { $0 != .Unknown }) { type in
                                    Text(type.name).tag(type)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .padding(.horizontal)
                        }, header: {
                            Text("Find a Movie/TV series")
                                .font(.system(size:12))
                                .textCase(.uppercase)
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.leading)
                                .padding(.horizontal, 24)
                                .padding(.top, 24)
                        })
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Section(content: {
                            TextField("", text: $searchTitle)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.horizontal)
                                .foregroundColor(.primary)
                        }, header: {
                            Text("Title")
                                .font(.system(size:12))
                                .textCase(.uppercase)
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.leading)
                                .padding(.horizontal, 24)
                                .padding(.top, 24)
                        }, footer: {
                            NavigationLink(destination: SearchTitleView(movieViewModel: movieViewModel, title: searchTitle, itemType: selectedType)) {
                                Text("Search")
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 8)
                                    .padding(.bottom, 12)
                                    .foregroundColor(.blue)
                            }
                            .disabled(searchTitle.isEmpty)
                            .onTapGesture {
                                movieViewModel.isSearching = true
                            }
                        })
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .background(Color(UIColor.secondarySystemBackground))
                    
                    GroupTitle(title: "Your Watchlist")
                    ScrollView(.horizontal) {
                        HStack {
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
                        HStack {
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
