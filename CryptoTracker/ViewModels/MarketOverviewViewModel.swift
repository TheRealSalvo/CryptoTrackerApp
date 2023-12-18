//
//  MarketOverviewViewModel.swift
//  CryptoTracker
//
//  Created by Paul Y on 2023-12-11.
//

import Foundation

class MarketOverviewViewModel: ObservableObject {
    @Published var coins = [MarketData]()
    
    private let decoder = JSONDecoder()
    
    @MainActor func getMarketData(vs_currency: Currency = .dollars) async throws {
        let (data, _) = try await APICallsManager.shared.updateMarketData(vs_currency: vs_currency.rawValue)
        coins = try JSONDecoder().decode([MarketData].self, from: data)
    }
    
    func updateCoins() async throws{
        try await getMarketData()
    }
}
