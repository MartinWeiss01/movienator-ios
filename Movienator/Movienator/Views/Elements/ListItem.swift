//
//  ListItem.swift
//  Movienator
//
//  Created by Martin Weiss on 16.06.2023.
//

import SwiftUI

struct ListItem: View {
    @State var title: String
    @State var releaseYear: String
    @State var posterURL: URL

    var body: some View {
        HStack(alignment: .top) {
            AsyncImage(url: posterURL) { phase in
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
                Text("\(title)")
                    .fontWeight(.bold)
                Text("\(releaseYear)")
                
                Spacer()
                
                Button("Details") {}
            }
            .padding(.all)
        }
    }
}

struct ListItem_Previews: PreviewProvider {
    static var previews: some View {
        ListItem(
            title: "Shrek",
            releaseYear: "2001",
            posterURL: URL(string: "https://image.tmdb.org/t/p/w500/iB64vpL3dIObOtMZgX3RqdVdQDc.jpg")!
        )
    }
}
