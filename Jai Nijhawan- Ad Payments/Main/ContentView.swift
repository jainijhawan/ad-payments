//
//  ContentView.swift
//  Jai Nijhawan- Ad Payments
//
//  Created by Jai Nijhawan on 26/08/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel(
        persistenceController: PersistenceController.shared
    )
    
    var body: some View {
        NavigationView {
            VStack(spacing: 40) {
                // App Title
                Text("Ad payments")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .padding(.top, 60)
                
                Spacer()
                
                // Buttons
                VStack(spacing: 20) {
                    Button(action: {
                        viewModel.showAddDialog()
                    }) {
                        Text("Add")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color.blue)
                            .cornerRadius(12)
                    }
                    
                    Button(action: {
                        viewModel.showViewDialog()
                    }) {
                        Text("View")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.blue)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color.blue.opacity(0.1))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.blue, lineWidth: 2)
                            )
                            .cornerRadius(12)
                    }
                }
                .padding(.horizontal, 40)
                
                Spacer()
            }
            .padding()
            .sheet(isPresented: $viewModel.showingAddDialog) {
                AddPaymentView()
                    .environment(\.managedObjectContext, viewModel.viewContext)
            }
            .sheet(isPresented: $viewModel.showingViewDialog) {
                ViewPaymentsView()
                    .environment(\.managedObjectContext, viewModel.viewContext)
            }
        }
    }
}

#Preview {
    ContentView()
}
