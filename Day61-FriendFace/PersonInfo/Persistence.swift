//
//  Persistence.swift
//  PersonInfo
//
//  Created by Zune Moe on 29/07/2021.
//

import CoreData
import Swift

struct PersistenceController {
    static let shared = PersistenceController()
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "PersonInfo")
//        container.viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("unresolved error \(error), \(error.userInfo)")
            }                        
        }
    }
}
