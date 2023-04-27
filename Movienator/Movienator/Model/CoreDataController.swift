//
//  CoreDataController.swift
//  Movienator
//
//  Created by Martin Weiss on 27.04.2023.
//

import Foundation
import CoreData

class CoreDataController: ObservableObject {
    let container = NSPersistentContainer(name: "Movienator")
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("[error] Core Data Controller failed to load: \(error.localizedDescription)")
            }
        }
    }
}
