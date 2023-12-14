
import SwiftUI

struct Card: Identifiable {
    var id = UUID()
    
    var name            : String
    var value           : Double
    var imageSymbol     : Image
    var marketCap       : Double
    var volume          : Double
    var priceChangePercentage24h : Double
    var sparkline       : [Double]
    
    init(name: String, value: Double, imageSymbol: Image, marketCap: Double, volume: Double, priceChangePercentage24h: Double = 0.0, sparkline: [Double] = []){
        self.name        = name
        self.value       = value
        self.imageSymbol = imageSymbol
        self.marketCap   = marketCap
        self.volume      = volume
        self.priceChangePercentage24h = priceChangePercentage24h
        self.sparkline  = sparkline
    }
    
    init(coin: MarketData){
        self.name        = coin.name
        self.value       = coin.currentPrice
        self.imageSymbol = Image("bitcoin")
        self.marketCap   = coin.marketCap
        self.volume      = coin.totalVolume
        self.priceChangePercentage24h = coin.priceChangePercentage24h
        self.sparkline  = coin.sparkline?.price ?? []
    }
}



