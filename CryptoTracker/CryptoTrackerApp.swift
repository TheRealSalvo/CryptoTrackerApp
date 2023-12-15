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
            //ContentView(viewModel: MarketOverviewViewModel())
            DetailView(detailModel: MarketData(id: "", symbol: "BTC", name: "Bitcoin", image: "bitcoin", currentPrice: 20.45, marketCap: 22.34, marketCapRank: 2, totalVolume: 45.56, high24h: 22.45, low24h: 17.26, priceChange24h: 5.345, priceChangePercentage24h: 0.456, marketCapChange24h: 0.567, marketCapChangePercentage24h: 0.543, circulatingSupply: 0.454, totalSupply: 23.54, maxSupply: 23.54, ath: 0.456, athChangePercentage: 0.456, athDate: "", atl: 0.456, atlChangePercentage: 0.456, atlDate: "", lastUpdated: "16/04/2023", sparkline: nil))

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
