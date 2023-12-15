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
    @Published var alertContentString: String = ""
    
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
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                alertContentString = "Received non-HTTP response"
                showAPIAlert = true
                return []
            }
            
            switch httpResponse.statusCode {
            case 200:
                return try JSONDecoder().decode([MarketData].self, from: data)
            case 429:
                alertContentString = "Request Limit Reached"
            case 401:
                alertContentString = "API key invalid"
            case 402:
                alertContentString = "Payment required for the API"
            case 403:
                alertContentString = "Unauthorized request"
            case 404:
                alertContentString = "Not found"
            default:
                alertContentString = "Error: code \(httpResponse.statusCode)"
            }
        }
        catch {
            if let urlError = error as? URLError {
                switch urlError.code {
                case .notConnectedToInternet:
                    alertContentString = "No network connection"
                case .timedOut:
                    alertContentString = "Request timed out"
                default:
                    alertContentString = "URL Error: \(urlError)"
                }
            } else {
                alertContentString = "Error: \(error.localizedDescription)"
            }
        }
        showAPIAlert = true
        return []
    }
    
    
    
    init() {
        updateCoins()
    }
    
    func updateCoins() {
        Task { @MainActor in
            do {
                coins = try await getMarketData()
                if coins.isEmpty == false {
                    print(coins[0])
                }
            } catch let error {
                print("Error: \((error))")
            }
        }
    }
}
