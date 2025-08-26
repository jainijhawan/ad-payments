//
//  ContentViewModel.swift
//  Jai Nijhawan- Ad Payments
//
//  Created by Jai Nijhawan on 26/08/25.
//

import SwiftUI
import CoreData
import Combine

@MainActor
class ContentViewModel: ObservableObject {
    @Published var showingAddDialog = false
    @Published var showingViewDialog = false
    
    private let persistenceController: PersistenceController
    
    init(persistenceController: PersistenceController = PersistenceController.shared) {
        self.persistenceController = persistenceController
    }
    
    // MARK: - Actions
    func showAddDialog() {
        showingAddDialog = true
    }
    
    func showViewDialog() {
        showingViewDialog = true
    }
    
    func dismissAddDialog() {
        showingAddDialog = false
    }
    
    func dismissViewDialog() {
        showingViewDialog = false
    }
    
    // MARK: - Core Data Context
    var viewContext: NSManagedObjectContext {
        persistenceController.container.viewContext
    }
}
