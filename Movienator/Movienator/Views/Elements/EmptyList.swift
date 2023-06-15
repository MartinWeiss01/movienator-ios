//
//  EmptyList.swift
//  Movienator
//
//  Created by Martin Weiss on 15.06.2023.
//

import SwiftUI

struct EmptyList: View {
    var text: String = "Oops! There are no movies or TV shows yet."
    var body: some View {
        VStack {
            Spacer()
            
            Image(systemName: "film")
                .font(.largeTitle)
                .foregroundColor(.gray)
                .padding(.bottom, 8)
            
            Text(text)
                .font(.caption)
                .foregroundColor(.gray)
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(10)
    }
}

struct EmptyList_Previews: PreviewProvider {
    static var previews: some View {
        EmptyList()
    }
}
