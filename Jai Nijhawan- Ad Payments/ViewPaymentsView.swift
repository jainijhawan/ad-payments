//
//  ViewPaymentsView.swift
//  Jai Nijhawan- Ad Payments
//
//  Created by Jai Nijhawan on 26/08/25.
//

import SwiftUI
import CoreData

struct ViewPaymentsView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = ViewPaymentsViewModel()
    
    var body: some View {
        NavigationView {
            Group {
                if !viewModel.hasPayments {
                    VStack {
                        Image(systemName: "list.bullet.rectangle.portrait")
                            .font(.system(size: 60))
                            .foregroundColor(.gray)
                            .padding(.bottom, 20)
                        
                        Text("No payments added yet")
                            .font(.title2)
                            .foregroundColor(.gray)
                        
                        Text("Use the Add button to create your first payment entry")
                            .font(.body)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List {
                        ForEach(viewModel.payments, id: \.id) { payment in
                            PaymentRowView(payment: payment) {
                                viewModel.selectPayment(payment)
                            }
                        }
                        .onDelete(perform: viewModel.deletePayments)
                    }
                }
            }
            .navigationTitle("View Payments")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Done") {
                        dismiss()
                    }
                }
                
                if viewModel.hasPayments {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                }
            }
            .sheet(isPresented: $viewModel.showingEditDialog) {
                if let payment = viewModel.selectedPayment {
                    EditPaymentView(payment: payment)
                        .environment(\.managedObjectContext, viewModel.viewContext)
                        .onDisappear {
                            viewModel.fetchPayments() // Refresh data when edit dialog is dismissed
                        }
                }
            }
        }
    }
}

struct PaymentRowView: View {
    let payment: AdPayment
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(payment.name ?? "Unknown")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text(payment.url ?? "")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    ViewPaymentsView()
}
