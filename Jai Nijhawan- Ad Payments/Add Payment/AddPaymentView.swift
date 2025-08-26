//
//  AddPaymentView.swift
//  Jai Nijhawan- Ad Payments
//
//  Created by Jai Nijhawan on 26/08/25.
//

import SwiftUI
import CoreData

struct AddPaymentView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = AddPaymentViewModel(
        persistenceController: PersistenceController.shared
    )
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name", text: $viewModel.name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.asciiCapable)
                    
                    TextField("URL", text: $viewModel.url)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                        .keyboardType(.asciiCapable)
                }
                
                Section {
                    Button(action: {
                        Task {
                            let success = await viewModel.savePayment()
                            if success {
                                dismiss()
                            }
                        }
                    }) {
                        HStack {
                            if viewModel.isLoading {
                                ProgressView()
                                    .scaleEffect(0.8)
                                    .foregroundColor(.white)
                            }
                            Text("Save")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(Color.blue)
                        .cornerRadius(8)
                    }
                    .disabled(viewModel.isLoading)
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets())
                }
            }
            .navigationTitle("Add Payments")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        viewModel.reset()
                        dismiss()
                    }
                }
            }
            .alert("Error", isPresented: $viewModel.showingAlert) {
                Button("OK") { }
            } message: {
                Text(viewModel.alertMessage)
            }
        }
    }
}

#Preview {
    AddPaymentView()
}


