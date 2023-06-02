//
//  MoviePosterPlaceholder.swift
//  Movienator
//
//  Created by Martin Weiss on 02.06.2023.
//

import SwiftUI

struct MoviePosterPlaceholder: View {
    let imageWidth: CGFloat = 100
    let imageHeight: CGFloat = 186
    
    var body: some View {
        Rectangle().fill(.gray)
            .frame(width: imageWidth, height: imageHeight)
            .cornerRadius(5)
    }
}

struct MoviePosterPlaceholder_Previews: PreviewProvider {
    static var previews: some View {
        MoviePosterPlaceholder()
    }
}
