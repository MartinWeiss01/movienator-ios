//
//  MovienatorApp.swift
//  Movienator
//
//  Created by Martin Weiss on 27.04.2023.
//

import SwiftUI

@main
struct MovienatorApp: App {
    @StateObject private var dataController = CoreDataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView(movieViewModel: MovieViewModel(moc: dataController.container.viewContext))
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
