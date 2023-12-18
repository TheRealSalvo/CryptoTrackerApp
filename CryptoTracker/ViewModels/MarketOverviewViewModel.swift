//
//  MarketOverviewViewModel.swift
//  CryptoTracker
//
//  Created by Paul Y on 2023-12-11.
//

import Foundation

class MarketOverviewViewModel: ObservableObject {
    @Published var coins = [MarketData]()
    
    private var _coinName2CoinDataMap : [String : MarketData] = [:]
    
    private let decoder = JSONDecoder()
    
    @MainActor func getMarketData(vs_currency: Currency = .dollars) async throws {
        let (data, _) = try await APICallsManager.shared.updateMarketData(vs_currency: vs_currency.rawValue)
        coins = try JSONDecoder().decode([MarketData].self, from: data)
        
        for coin in coins{
            _coinName2CoinDataMap.updateValue(coin, forKey: coin.name)
        }
    }
    
    func updateCoins() async throws{
        try await getMarketData()
    }
    
    func getCoinDataByName(name : String) -> MarketData?{
        return _coinName2CoinDataMap[name]
    }
}
