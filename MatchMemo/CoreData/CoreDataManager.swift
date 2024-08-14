//
//  CoreDataManager.swift
//  MatchMemo
//
//  Created by Роман on 14.08.2024.
//

import Foundation
import CoreData

final class CoreDataManager {
    static let instance = CoreDataManager()
    
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "MatchMemo")
        container.loadPersistentStores { descption, error in
            if let error = error{
                print("Error looading core data\(error)")
            }
        }
        context = container.viewContext
    }
    
    func save() {
        do {
            try context.save()
        }catch let error {
            print("Save data erroe \(error.localizedDescription)")
        }
        
    }
}
