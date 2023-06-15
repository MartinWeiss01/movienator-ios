//
//  LibraryScrollView.swift
//  Movienator
//
//  Created by Martin Weiss on 15.06.2023.
//

import SwiftUI

struct LibraryScrollView: View {
    let movies: [MovieItem]
    let onTapMovie: (MovieItem) -> Void
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                Spacer(minLength: 20)
                ForEach(movies) { movie in
                    LibraryItemView(movie: movie)
                        .onTapGesture {
                            onTapMovie(movie)
                        }
                }
                Spacer(minLength: 20)
            }
        }
    }
}

struct LibraryItemView: View {
    let movie: MovieItem
    
    var body: some View {
        Image(uiImage: movie.posterAssetName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 125)
    }
}
