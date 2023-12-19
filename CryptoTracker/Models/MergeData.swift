//
//  MergeData.swift
//  CryptoTracker
//
//  Created by SHOHJAHON on 18/12/23.
//

import Foundation

struct MergeData: Identifiable, Hashable {
    
    static func == (lhs: MergeData, rhs: MergeData) -> Bool {
        lhs.coin.name == rhs.coin.name &&
        lhs.data.name == rhs.data.name
    }
    
    let id: UUID = .init()
    let coin: FavoriteCoin
    let data: MarketData
    
    init(_ coin: FavoriteCoin, _ data: MarketData) {
        self.coin = coin
        self.data = data
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(coin.name)
        hasher.combine(data.name)
    }
}
