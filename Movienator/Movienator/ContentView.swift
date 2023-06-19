//
//  ContentView.swift
//  Movienator
//
//  Created by Martin Weiss on 27.04.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var movieViewModel: MovieViewModel
    @State private var selectedScreen = 0
    
    var body: some View {
        TabView(selection: $selectedScreen) {
            DashboardView(movieViewModel: movieViewModel)
                .tabItem {
                    Image(systemName: "house")
                    Text("Dashboard")
                }
                .tag(0)
            
            DiscoverView(movieViewModel: movieViewModel)
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Discover")
                }
                .tag(1)
            
            StatsView(movieViewModel: movieViewModel)
                .tabItem {
                    Image(systemName: "chart.bar.fill")
                    Text("Stats")
                }
                .tag(2)
        }
        
    }
}

/*
 struct ContentView_Previews: PreviewProvider {
 static var previews: some View {
 ContentView(movieViewModel: MovieViewModel())
 }
 }
 */
