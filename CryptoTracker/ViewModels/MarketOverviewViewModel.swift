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
        
        // Where do I handle this?
//            guard let httpResponse = response as? HTTPURLResponse else {
//                alertContentString = "Received non-HTTP response"
//                showAPIAlert = true
//                return
//            }
        
        coins = try JSONDecoder().decode([MarketData].self, from: data)
    }
    
    func updateCoins() async throws{
        try await getMarketData()
    }

//    private func errorHandler (_ error: Error) {
//        if let urlError = error as? URLError {
//            switch urlError.code {
//            case .notConnectedToInternet:
//                alertContentString = "No network connection"
//            case .timedOut:
//                alertContentString = "Request timed out"
//            default:
//                alertContentString = "URL Error: \(urlError)"
//            }
//        } else {
//            alertContentString = "Error: \(error.localizedDescription)"
//        }
//    }
}
