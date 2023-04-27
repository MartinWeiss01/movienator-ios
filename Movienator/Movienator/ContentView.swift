//
//  ContentView.swift
//  Movienator
//
//  Created by Martin Weiss on 27.04.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var movieViewModel: MovieViewModel
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

/*
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(movieViewModel: MovieViewModel())
    }
}
*/
