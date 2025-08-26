//
//  PersistenceController.swift
//  Jai Nijhawan- Ad Payments
//
//  Created by Jai Nijhawan on 26/08/25.
//

import CoreData
import Foundation

struct PersistenceController {
    static let shared = PersistenceController()
    
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        // Add sample data for previews
        let samplePayment = AdPayment(context: viewContext)
        samplePayment.id = UUID()
        samplePayment.name = "Sample Ad"
        samplePayment.url = "https://example.com"
        
        do {
            try viewContext.save()
        } catch {
            // Handle error appropriately in production
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "AdPayments")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Handle error appropriately in production
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}

// MARK: - Core Data Operations
extension PersistenceController {
    
    func save() {
        let context = container.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Handle error appropriately in production
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    func createAdPayment(name: String, url: String) -> AdPayment {
        let context = container.viewContext
        let adPayment = AdPayment(context: context)
        adPayment.id = UUID()
        adPayment.name = name
        adPayment.url = url
        return adPayment
    }
    
    func deleteAdPayment(_ adPayment: AdPayment) {
        let context = container.viewContext
        context.delete(adPayment)
    }
}
