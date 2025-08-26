//
//  ViewPaymentsView.swift
//  Jai Nijhawan- Ad Payments
//
//  Created by Jai Nijhawan on 26/08/25.
//

import SwiftUI
import CoreData

struct ViewPaymentsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \AdPayment.name, ascending: true)],
        animation: .default)
    private var payments: FetchedResults<AdPayment>
    
    @State private var selectedPayment: AdPayment?
    @State private var showingEditDialog = false
    
    var body: some View {
        NavigationView {
            Group {
                if payments.isEmpty {
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
                        ForEach(payments, id: \.id) { payment in
                            PaymentRowView(payment: payment) {
                                selectedPayment = payment
                                showingEditDialog = true
                            }
                        }
                        .onDelete(perform: deletePayments)
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
                
                if !payments.isEmpty {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                }
            }
            .sheet(isPresented: $showingEditDialog) {
                if let payment = selectedPayment {
                    EditPaymentView(payment: payment)
                        .environment(\.managedObjectContext, viewContext)
                }
            }
        }
    }
    
    private func deletePayments(offsets: IndexSet) {
        withAnimation {
            offsets.map { payments[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                // Handle the error appropriately
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
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
