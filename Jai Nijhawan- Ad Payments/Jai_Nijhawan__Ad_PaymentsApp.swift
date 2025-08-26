//
//  Jai_Nijhawan__Ad_PaymentsApp.swift
//  Jai Nijhawan- Ad Payments
//
//  Created by Jai Nijhawan on 26/08/25.
//

import SwiftUI
import CoreData

@main
struct Jai_Nijhawan__Ad_PaymentsApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
