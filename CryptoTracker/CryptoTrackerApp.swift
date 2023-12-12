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
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: MarketOverviewViewModel())
        }
        .modelContainer(for: FavoriteCoin.self)
    }
}
