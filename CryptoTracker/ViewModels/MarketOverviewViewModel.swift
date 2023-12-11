//
//  MarketOverviewViewModel.swift
//  CryptoTracker
//
//  Created by Paul Y on 2023-12-11.
//

import Foundation

class MarketOverviewViewModel: ObservableObject {
    
    @Published var coins = [MarketData]()
    @Published var isReady = false
    var currency: Currency = .dollars

    let decoder = JSONDecoder()
    
    var components = URLComponents(string: "https://api.coingecko.com")

    func getMarketData() async throws -> [MarketData] {
        guard var components = self.components else{
            throw URLError(.badURL)
        }
        
        components.path       = "/api/v3/coins/markets"
        components.queryItems = [
            URLQueryItem(name: "vs_currency", value: "usd"),
            URLQueryItem(name: "order",     value: "market_cap_desc"),
            URLQueryItem(name: "per_page",  value: "100"),
            URLQueryItem(name: "page",      value: "1"),
            URLQueryItem(name: "sparkline", value: "true"),
        ]
        
        guard let url = components.url else{
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
            } catch let error {
                print("Error: \((error))")
            }
        }
    }
}