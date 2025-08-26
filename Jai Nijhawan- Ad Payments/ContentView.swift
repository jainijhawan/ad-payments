//
//  ContentView.swift
//  Jai Nijhawan- Ad Payments
//
//  Created by Jai Nijhawan on 26/08/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var showingAddDialog = false
    @State private var showingViewDialog = false
    
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
                        showingAddDialog = true
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
                        showingViewDialog = true
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
            .sheet(isPresented: $showingAddDialog) {
                AddPaymentView()
                    .environment(\.managedObjectContext, viewContext)
            }
            .sheet(isPresented: $showingViewDialog) {
                ViewPaymentsView()
                    .environment(\.managedObjectContext, viewContext)
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
