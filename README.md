# Ad Payments iOS App

## Overview
A native iOS app built with SwiftUI that allows users to manage ad payment entries with persistent storage using Core Data.

## Features
- **Main Screen**: Clean interface with "Ad payments" title and two main action buttons
- **Add Payments**: Modal dialog for creating new payment entries with validation
- **View Payments**: List view showing all saved entries with edit functionality
- **Edit Payments**: Modal dialog for updating existing payment entries
- **Data Persistence**: Core Data implementation for reliable local storage
- **Input Validation**: Comprehensive validation for required fields and URL format

## Architecture & Technical Decisions

### Storage Choice: Core Data
I chose Core Data over SQLite or UserDefaults for the following reasons:
- **Scalability**: Better performance with larger datasets
- **Relationships**: Future-ready for complex data relationships
- **Memory Management**: Automatic object lifecycle management
- **Threading**: Built-in support for background operations
- **Migration**: Easier data model evolution

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

### MVVM Architecture Benefits
- **Separation of Concerns**: Business logic separated from UI code
- **Testability**: ViewModels can be unit tested independently
- **Reactive UI**: @Published properties automatically update the interface
- **Async Operations**: Modern async/await pattern for database operations
- **State Management**: Centralized state handling with loading and error states
- **Maintainability**: Clear code organization and responsibilities

## Validation Rules
- **Name Field**: Cannot be blank (trimmed for whitespace)
- **URL Field**: Must start with `http://` or `https://` and be a valid URL format
- **Error Handling**: User-friendly alerts for validation failures and save errors

## UI Design Decisions
- **Modern iOS Design**: Following Apple's Human Interface Guidelines
- **Accessibility**: Proper semantic labels and navigation structure
- **Consistent Styling**: Unified color scheme and typography
- **Responsive Layout**: Adaptive spacing and sizing for different screen sizes
- **Professional Appearance**: Clean, minimalist design with proper visual hierarchy

## Time Spent
**Total Time**: ~4 hours

### Breakdown:
- **Planning & Setup** (30 minutes): Project analysis, architecture planning
- **Core Data Implementation** (45 minutes): Model creation, persistence controller
- **UI Development** (60 minutes): Main screen, Add/View/Edit dialogs
- **Validation & Error Handling** (20 minutes): Input validation, user feedback
- **MVVM Refactoring** (90 minutes): Implementing ViewModels, async operations, state management
- **Project Restructuring** (15 minutes): Feature-based folder organization
- **Testing & Polish** (20 minutes): UI refinements, testing edge cases

## Limitations & Future Improvements

### Current Limitations:
1. **URL Validation**: Basic validation that checks format but doesn't verify reachability
2. **No Search/Filter**: No search functionality in the View Payments list
3. **Limited Sorting**: Only alphabetical sorting by name
4. **No Backup**: No cloud sync or backup functionality

### Potential Improvements:
1. **Enhanced URL Validation**: Network reachability checks
2. **Search & Filter**: Text search and category filtering
3. **Data Export**: CSV/JSON export functionality
4. **Cloud Sync**: iCloud integration for cross-device synchronization
5. **Analytics**: Usage tracking and statistics
6. **Bulk Operations**: Multi-select and bulk delete/edit
7. **Categories**: Payment categorization system
8. **Dark Mode**: Enhanced dark mode support with custom colors

## Testing
The app has been tested for:
- ✅ Add new payment entries with valid data
- ✅ Validation error messages for invalid inputs
- ✅ View and edit existing entries
- ✅ Data persistence across app launches
- ✅ Delete functionality in list view
- ✅ Empty state handling

## Build Requirements
- iOS 15.0+
- Xcode 14.0+
- Swift 5.7+

## Installation
1. Open `Jai Nijhawan- Ad Payments.xcodeproj` in Xcode
2. Select target device or simulator
3. Build and run the project

---

*Developed by Jai Nijhawan as part of iOS Developer Technical Test*