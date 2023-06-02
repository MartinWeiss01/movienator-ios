//
//  DashboardView.swift
//  Movienator
//
//  Created by Martin Weiss on 10.05.2023.
//

import SwiftUI

struct DashboardView: View {
    @StateObject var movieViewModel: MovieViewModel
    
    @State var searchTitle: String = ""
    
    var body: some View {
        NavigationView {
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
