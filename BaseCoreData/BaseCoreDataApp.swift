//
//  BaseCoreDataApp.swift
//  BaseCoreData
//
//  Created by Work on 30/09/2023.
//

import SwiftUI

@main
struct BaseCoreDataApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
