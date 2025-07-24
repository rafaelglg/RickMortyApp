//
//  SettingsView.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 18/7/25.
//

import SwiftUI

struct SettingsView: View {
    
    @State var viewModel: SettingsViewModel
    
    var body: some View {
        List {
            cacheSection
            applicationSection
        }
        
        .onAppear(perform: viewModel.getCacheSizeInMB)
        .confirmationDialog(
            "Clear Cache?",
            isPresented: $viewModel.showingClearCacheConfirmation,
            titleVisibility: .visible
        ) {
            Button("Delete Entire Cache", role: .destructive, action: viewModel.clearCache)
                .accessibilityIdentifier("deleteCacheButton")
            
            Button("Cancel", role: .cancel) { }
                .accessibilityIdentifier("cancelClearCacheButton")
        } message: {
            Text("This will permanently remove all cached characters. You’ll need to re-download data next time. Do you want to continue?")
        }
    }
    
    var cacheSection: some View {
        
        Section {
            HStack {
                Button(action: viewModel.toggleCacheConfirmation) {
                    HStack {
                        Image(systemName: "trash")
                        Text("Clear cache")
                    }
                }
                .disabled(viewModel.isCacheEmpty)
                .accessibilityIdentifier("clearCacheButton")
                
                Spacer()
                Text("Size: \(viewModel.cacheSizeInMB) MB")
                    .font(.callout)
                    .foregroundStyle(.secondary)
            }
        } header: {
            Text("App Storage")
                .accessibilityAddTraits(.isHeader)
                .accessibilityIdentifier("AppStorageSectionHeader")
        } footer: {
            Text("Cached characters help speed up the app. You can clear them to free up space. This action is permanent.")
        }
    }
    
    var applicationSection: some View {
        
        Section {
            
            HStack {
                Text("Version")
                Spacer()
                Text("1.0")
                    .foregroundStyle(.secondary)
            }
            
            HStack {
                Text("Build Number")
                Spacer()
                Text("1")
                    .foregroundStyle(.secondary)
            }
        } header: {
            Text("Application")
        } footer: {
            Text("Created by Rafael loggiodice.")
        }
    }
}

#Preview("Mock preview") {
    let settingsViewModelMock = SettingsViewModelMock()
    SettingsView(viewModel: settingsViewModelMock)
}
