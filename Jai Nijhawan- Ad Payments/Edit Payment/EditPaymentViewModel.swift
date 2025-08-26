//
//  EditPaymentViewModel.swift
//  Jai Nijhawan- Ad Payments
//
//  Created by Jai Nijhawan on 26/08/25.
//

import Foundation
import CoreData
import UIKit
import Combine

@MainActor
class EditPaymentViewModel: ObservableObject {
    @Published var name = ""
    @Published var url = ""
    @Published var showingAlert = false
    @Published var alertMessage = ""
    @Published var isLoading = false
    
    private let payment: AdPayment
    private let persistenceController: PersistenceController
    
    init(payment: AdPayment, persistenceController: PersistenceController) {
        self.payment = payment
        self.persistenceController = persistenceController
        
        // Initialize with existing data
        self.name = payment.name ?? ""
        self.url = payment.url ?? ""
    }
    
    // MARK: - Validation
    private func validateInput() -> ValidationResult {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedURL = url.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if trimmedName.isEmpty {
            return .failure("Name cannot be blank.")
        }
        
        if !isValidURL(trimmedURL) {
            return .failure("Please enter a valid URL (e.g., https://www.example.com)")
        }
        
        return .success(trimmedName, trimmedURL)
    }
    
    private func isValidURL(_ urlString: String) -> Bool {
        guard !urlString.isEmpty else { return false }
        
        // Check if URL starts with http:// or https://
        let lowercaseURL = urlString.lowercased()
        guard lowercaseURL.hasPrefix("http://") || lowercaseURL.hasPrefix("https://") else {
            return false
        }
        
        // Check if it's a valid URL structure
        guard let url = URL(string: urlString) else {
            return false
        }
        
        // Ensure the URL has a valid host
        guard let host = url.host, !host.isEmpty else {
            return false
        }
        
        // Check if host contains at least one dot (for TLD)
        guard host.contains(".") else {
            return false
        }
        
        // Split host by dots to validate domain structure
        let hostComponents = host.components(separatedBy: ".")
        
        // Must have at least 2 components (domain + TLD)
        guard hostComponents.count >= 2 else {
            return false
        }
        
        // Check that no component is empty and each has valid characters
        for component in hostComponents {
            guard !component.isEmpty,
                  component.allSatisfy({ $0.isLetter || $0.isNumber || $0 == "-" }),
                  !component.hasPrefix("-"),
                  !component.hasSuffix("-") else {
                return false
            }
        }
        
        // Check that TLD (last component) is at least 2 characters and contains only letters
        let tld = hostComponents.last!
        guard tld.count >= 2, tld.allSatisfy({ $0.isLetter }) else {
            return false
        }
        
        // Additional validation using URL components
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
              components.scheme != nil,
              components.host != nil else {
            return false
        }
        
        return true
    }
    
    // MARK: - Actions
    func updatePayment() async -> Bool {
        isLoading = true
        
        let validationResult = validateInput()
        
        switch validationResult {
        case .failure(let message):
            alertMessage = message
            showingAlert = true
            isLoading = false
            return false
            
        case .success(let validName, let validURL):
            do {
                try await updateInDatabase(name: validName, url: validURL)
                isLoading = false
                return true
            } catch {
                alertMessage = "Failed to update payment. Please try again."
                showingAlert = true
                isLoading = false
                return false
            }
        }
    }
    
    private func updateInDatabase(name: String, url: String) async throws {
        let context = persistenceController.container.viewContext
        
        payment.name = name
        payment.url = url
        
        try context.save()
    }
    
    func resetToOriginal() {
        name = payment.name ?? ""
        url = payment.url ?? ""
        showingAlert = false
        alertMessage = ""
        isLoading = false
    }
    
    // MARK: - Computed Properties
    var hasChanges: Bool {
        let currentName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let currentURL = url.trimmingCharacters(in: .whitespacesAndNewlines)
        let originalName = payment.name ?? ""
        let originalURL = payment.url ?? ""
        
        return currentName != originalName || currentURL != originalURL
    }
}

// MARK: - Validation Result
private enum ValidationResult {
    case success(String, String) // name, url
    case failure(String) // error message
}
