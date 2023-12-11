//
//  MarketOverviewViewModel.swift
//  CryptoTracker
//
//  Created by Paul Y on 2023-12-11.
//

import Foundation

class MarketOverviewVewModel: ObservableObject {
    
    @Published var coins = [MarketData]()
    @Published var isReady = false
    var currency: Currency = .dollars

    let decoder = JSONDecoder()

    func getMarketData() async throws -> [MarketData] {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?order=market_cap_desc&per_page=100&page=1&vs_currency=usd&sparkline=true") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let marketData = try JSONDecoder().decode([MarketData].self, from: data)
        self.isReady = true
        return marketData
    }
    
    init() {
        updateCoins()
    }

    func updateCoins() {
        Task { @MainActor in
            do {
                coins = try await getMarketData()
                print(coins![0])
            } catch let error {
                print("Error: \((error))")
            }
        }
    }
}
