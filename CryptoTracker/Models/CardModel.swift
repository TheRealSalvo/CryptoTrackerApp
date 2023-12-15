
import SwiftUI

struct Card: Identifiable {
    var id = UUID()
    
    var name            : String
    var value           : Double
    var imageURL        : String
    var marketCap       : Double
    var volume          : Double
    var priceChangePercentage24h : Double
    var sparkline       : [Double]
    
    init(name: String, value: Double, imageSymbol: String, marketCap: Double, volume: Double, priceChangePercentage24h: Double = 0.0, sparkline: [Double] = []){
        self.name        = name
        self.value       = value
        self.imageURL = imageSymbol
        self.marketCap   = marketCap
        self.volume      = volume
        self.priceChangePercentage24h = priceChangePercentage24h
        self.sparkline  = sparkline
    }
    
    init(coin: MarketData){
        self.name        = coin.name
        self.value       = coin.currentPrice
        self.imageURL    = coin.image
        self.marketCap   = coin.marketCap
        self.volume      = coin.totalVolume
        self.priceChangePercentage24h = coin.priceChangePercentage24h
        self.sparkline  = coin.sparkline?.price ?? []
    }
}



