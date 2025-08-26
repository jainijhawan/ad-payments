//
//  AddPaymentView.swift
//  Jai Nijhawan- Ad Payments
//
//  Created by Jai Nijhawan on 26/08/25.
//

import SwiftUI
import CoreData

struct AddPaymentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var name = ""
    @State private var url = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("URL", text: $url)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.URL)
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                }
                
                Section {
                    Button(action: savePayment) {
                        Text("Save")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets())
                }
            }
            .navigationTitle("Add Payments")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .alert("Error", isPresented: $showingAlert) {
                Button("OK") { }
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    private func savePayment() {
        // Validation
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedURL = url.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if trimmedName.isEmpty {
            alertMessage = "Name cannot be blank."
            showingAlert = true
            return
        }
        
        if !isValidURL(trimmedURL) {
            alertMessage = "URL must be a valid http:// or https:// format."
            showingAlert = true
            return
        }
        
        // Save to Core Data
        let newPayment = AdPayment(context: viewContext)
        newPayment.id = UUID()
        newPayment.name = trimmedName
        newPayment.url = trimmedURL
        
        do {
            try viewContext.save()
            dismiss()
        } catch {
            alertMessage = "Failed to save payment. Please try again."
            showingAlert = true
        }
    }
    
    private func isValidURL(_ urlString: String) -> Bool {
        guard !urlString.isEmpty else { return false }
        
        // Check if URL starts with http:// or https://
        let lowercaseURL = urlString.lowercased()
        guard lowercaseURL.hasPrefix("http://") || lowercaseURL.hasPrefix("https://") else {
            return false
        }
        
        // Check if it's a valid URL
        guard let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) else {
            return false
        }
        
        return true
    }
}

#Preview {
    AddPaymentView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
