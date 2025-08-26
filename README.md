# Ad Payments iOS App

## Overview
A native iOS app built with SwiftUI that allows users to manage ad payment entries with persistent storage using Core Data.

## Demo Video

https://github.com/user-attachments/assets/e9941aae-3b65-4b47-8274-325ebce9d620


## Features
- **Main Screen**: Clean interface with "Ad payments" title and two main action buttons
- **Add Payments**: Modal dialog for creating new payment entries with validation
- **View Payments**: List view showing all saved entries with edit functionality
- **Edit Payments**: Modal dialog for updating existing payment entries
- **Data Persistence**: Core Data implementation for reliable local storage
- **Input Validation**: Comprehensive validation for required fields and URL format

## Architecture & Technical Decisions

### App Architecture
- **SwiftUI + MVVM**: Modern declarative UI with proper separation of concerns
- **Feature-Based Organization**: Each feature is self-contained in its own folder
- **Environment Injection**: Core Data context passed through SwiftUI environment
- **Modular Views**: Separate view files for different functionalities
- **Centralized Persistence**: Single PersistenceController managing all Core Data operations

### Project Structure
```
Jai Nijhawan- Ad Payments/
├── Add Payment/
│   ├── AddPaymentView.swift
│   └── AddPaymentViewModel.swift
├── View Payments/
│   ├── ViewPaymentsView.swift
│   └── ViewPaymentsViewModel.swift
├── Edit Payment/
│   ├── EditPaymentView.swift
│   └── EditPaymentViewModel.swift
├── Main/
│   ├── ContentView.swift
│   └── ContentViewModel.swift
├── Services/
│   └── PersistenceController.swift
├── AdPayments.xcdatamodeld/
├── Assets.xcassets/
└── Jai_Nijhawan__Ad_PaymentsApp.swift
```

### Key Features by Folder
- **Main/**: Contains the main screen with navigation and action buttons
- **Add Payment/**: Form-based modal for creating new payment entries with validation
- **View Payments/**: List interface showing all saved entries with navigation to edit
- **Edit Payment/**: Form-based modal for updating existing payment entries
- **Services/**: Core Data stack management and business logic operations

## Validation Rules
- **Name Field**: Cannot be blank (trimmed for whitespace)
- **URL Field**: Must be a properly formatted URL with valid domain structure:
  - Must start with `http://` or `https://`
  - Must contain a valid domain with proper TLD (e.g., `.com`, `.org`)
  - Domain components must contain only letters, numbers, and hyphens
  - Examples: `https://www.google.com`, `http://example.org`
  - Invalid examples: `http://google`, `https://invalid.`, `http://test`
- **Error Handling**: User-friendly alerts for validation failures and save errors

## Build Requirements
- iOS 15.0+
- Xcode 14.0+
- Swift 5.7+

## Installation
1. Open `Jai Nijhawan- Ad Payments.xcodeproj` in Xcode
2. Select target device or simulator
3. Build and run the project
