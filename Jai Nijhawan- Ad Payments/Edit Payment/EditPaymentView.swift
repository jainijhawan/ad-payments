//
//  EditPaymentView.swift
//  Jai Nijhawan- Ad Payments
//
//  Created by Jai Nijhawan on 26/08/25.
//

import SwiftUI
import CoreData

struct EditPaymentView: View {
    @Environment(\.dismiss) private var dismiss
    
    let payment: AdPayment
    @StateObject private var viewModel: EditPaymentViewModel
    
    init(payment: AdPayment) {
        self.payment = payment
        self._viewModel = StateObject(wrappedValue: EditPaymentViewModel(payment: payment))
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name", text: $viewModel.name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("URL", text: $viewModel.url)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.URL)
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                }
                
                Section {
                    Button(action: {
                        Task {
                            let success = await viewModel.updatePayment()
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
            .navigationTitle("Edit Ad Payment")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        viewModel.resetToOriginal()
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
    let context = PersistenceController.preview.container.viewContext
    let samplePayment = AdPayment(context: context)
    samplePayment.id = UUID()
    samplePayment.name = "Sample Ad"
    samplePayment.url = "https://example.com"
    
    return EditPaymentView(payment: samplePayment)
}
