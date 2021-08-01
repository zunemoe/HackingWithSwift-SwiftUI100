//
//  PersonInfoApp.swift
//  PersonInfo
//
//  Created by Zune Moe on 29/07/2021.
//

import SwiftUI

@main
struct PersonInfoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            PersonView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
