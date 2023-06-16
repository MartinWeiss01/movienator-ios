//
//  DiscoverView.swift
//  Movienator
//
//  Created by Martin Weiss on 16.06.2023.
//

import SwiftUI

struct DiscoverView: View {
    @StateObject var movieViewModel: MovieViewModel
    let DEFAULT_TMDB: Int64 = 0
    
    @State private var selectedType: ItemType = .Movie
    @State private var selectedTMDBID: Int64 = 0

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(
                        content: {
                            Picker("Select Type", selection: $selectedType) {
                                ForEach(ItemType.allCases.filter { $0 != .Unknown }) { type in
                                    Text(type.name).tag(type)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .onChange(of: selectedType) { newVal in
                                selectedTMDBID = DEFAULT_TMDB
                            }
                            
                            Picker("Similar to", selection: $selectedTMDBID) {
                                Text("None").tag(DEFAULT_TMDB)
                                ForEach(movieViewModel.movieItems.filter { $0.type == selectedType }) { movieItem in
                                    Text(movieItem.title).tag(movieItem.tmdb)
                                }
                            }
                        },
                        header: {
                            Text("Get recommendations")
                        },
                        footer: {
                            Button("Find") {
                                Task {
                                    await movieViewModel.discover(tmdbId: selectedTMDBID, type: selectedType)
                                }
                            }
                            .disabled(selectedTMDBID == DEFAULT_TMDB)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical)
                        }
                    )
                }
            }
            .navigationTitle("Discover")
        }
    }
}
