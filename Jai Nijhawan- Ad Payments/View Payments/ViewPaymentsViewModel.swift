//
//  ViewPaymentsViewModel.swift
//  Jai Nijhawan- Ad Payments
//
//  Created by Jai Nijhawan on 26/08/25.
//

import Foundation
import CoreData
import SwiftUI
import Combine

@MainActor
class ViewPaymentsViewModel: ObservableObject {
    @Published var selectedPayment: AdPayment?
    @Published var showingEditDialog = false
    @Published var payments: [AdPayment] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let persistenceController: PersistenceController
    
    init(persistenceController: PersistenceController = PersistenceController.shared) {
        self.persistenceController = persistenceController
        fetchPayments()
    }
    
    // MARK: - Data Operations
    func fetchPayments() {
        isLoading = true
        let context = persistenceController.container.viewContext
        
        let request: NSFetchRequest<AdPayment> = AdPayment.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \AdPayment.name, ascending: true)]
        
        do {
            payments = try context.fetch(request)
            isLoading = false
        } catch {
            errorMessage = "Failed to load payments"
            isLoading = false
        }
    }
    
    func deletePayments(at offsets: IndexSet) {
        let context = persistenceController.container.viewContext
        
        for index in offsets {
            let payment = payments[index]
            context.delete(payment)
        }
        
        do {
            try context.save()
            fetchPayments() // Refresh the list
        } catch {
            errorMessage = "Failed to delete payment"
        }
    }
    
    func deletePayment(_ payment: AdPayment) {
        let context = persistenceController.container.viewContext
        context.delete(payment)
        
        do {
            try context.save()
            fetchPayments() // Refresh the list
        } catch {
            errorMessage = "Failed to delete payment"
        }
    }
    
    // MARK: - Navigation
    func selectPayment(_ payment: AdPayment) {
        selectedPayment = payment
        showingEditDialog = true
    }
    
    func dismissEditDialog() {
        showingEditDialog = false
        selectedPayment = nil
    }
    
    // MARK: - Computed Properties
    var hasPayments: Bool {
        !payments.isEmpty
    }
    
    var paymentCount: Int {
        payments.count
    }
    
    // MARK: - Core Data Context
    var viewContext: NSManagedObjectContext {
        persistenceController.container.viewContext
    }
}
