//
//  CryptoTrackerApp.swift
//  CryptoTracker
//
//  Created by Salvatore Attanasio on 11/12/23.
//

import SwiftUI
import SwiftData

@main
struct CryptoTrackerApp: App {
    
    
    let container: ModelContainer
    
    init() {
        do {
            container = try ModelContainer(for: FavoriteCoin.self)
            
            // Check if it's empty, if not returns the container that already exists
            try prepopulateDataIfNeeded()
        } catch {
            fatalError("Failed to create container")
        }
    }
    
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: MarketOverviewViewModel())
        }
        .modelContainer(for: FavoriteCoin.self)
    }
    
    @MainActor private func prepopulateDataIfNeeded() throws {
        var itemFetchDescriptor = FetchDescriptor<FavoriteCoin>()
        itemFetchDescriptor.fetchLimit = 1
        
        // Check if the container is empty
        if try container.mainContext.fetch(itemFetchDescriptor).isEmpty {
            // Pre-populate the store
            let initialCoins = [FavoriteCoin(name: "Bitcoin")]
            for coin in initialCoins {
                container.mainContext.insert(coin)
            }
            
            // Save changes to the context
            try container.mainContext.save()
        }
    }
}
