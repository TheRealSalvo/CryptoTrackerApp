//
//  MarketOverviewViewModel.swift
//  CryptoTracker
//
//  Created by Paul Y on 2023-12-11.
//

import Foundation

class MarketOverviewViewModel: ObservableObject {
    
    @Published var coins = [MarketData]()
    @Published var showAPIAlert = false
    @Published var alertContent: Int = 0
    
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
            URLQueryItem(name: "x_cg_demo_api_key", value: Bundle.main.infoDictionary?["API_KEY"] as? String),
        ]
        
        guard let url = components.url else{
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        if let httpResponse = response as? HTTPURLResponse{
            if httpResponse.statusCode == 200{
                print("OK!")
                
//                //Testing if the pop up gets created
//                alertContent = httpResponse.statusCode
//                showAPIAlert = true
//                print("created pop up alert")

            }
            if httpResponse.statusCode == 429{
                print("Request Limit Reached!")
                
                print(response)
                if let retryAfterValue = httpResponse.value(forHTTPHeaderField: "retry-after") as Any?{
                    print("retry after \(retryAfterValue) seconds")
                }
                return []
            }
            if httpResponse.statusCode != 200 {
                alertContent = httpResponse.statusCode
                showAPIAlert = true
                print("Should have showed a pop up alert!")
            }
        }
        
        let marketData = try JSONDecoder().decode([MarketData].self, from: data)
        return marketData
    }
    
    init() {
        updateCoins()
    }

    func updateCoins() {
        Task { @MainActor in
            do {
                coins = try await getMarketData()
                print(coins[0])
            } catch let error {
                print("Error: \((error))")
            }
        }
    }
}
