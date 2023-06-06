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
            if let movieItem = movieViewModel.selectedSearchItem {
                
            
                ScrollView {
                    VStack {
                        Text(movieItem.title)
                    }
                }
            }
        }
        
        .navigationTitle("Detail")
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                Button("Zavrit") {
                    detailPresented.toggle()
                }
            }
        }
    }
}
