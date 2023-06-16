//
//  DiscoverView.swift
//  Movienator
//
//  Created by Martin Weiss on 16.06.2023.
//

import SwiftUI

struct DiscoverView: View {
    @StateObject var movieViewModel: MovieViewModel
    let DEFAULT_UUID = UUID(uuidString: "98EA8B7A-6666-6666-6666-25E6A9EB8824")!
    
    @State private var selectedType: ItemType = .Movie
    @State private var selectedItemUUID: UUID = UUID(uuidString: "98EA8B7A-6666-6666-6666-25E6A9EB8824")!
    

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
                                selectedItemUUID = DEFAULT_UUID
                            }
                            
                            Picker("Similar to", selection: $selectedItemUUID) {
                                Text("None").tag(DEFAULT_UUID)
                                ForEach(movieViewModel.movieItems.filter { $0.type == selectedType }) { movieItem in
                                    Text(movieItem.title).tag(movieItem.id)
                                }
                            }
                        },
                        header: {
                            Text("Get recommendations")
                        },
                        footer: {
                            Button("Find") {
                                print("\(selectedItemUUID)")
                            }
                            .disabled(selectedItemUUID == DEFAULT_UUID)
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
