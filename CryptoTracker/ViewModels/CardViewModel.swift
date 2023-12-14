import SwiftUI
class CardViewModel {
    var cards : [Card] = [
        Card(name: "BTC", value: 23.45, imageSymbol: Image("bitcoin"), marketCap: "MarketCap 43.75$B", volume: "Volume 24h 31,60$B", priceChangePercentage24h: "0,56"),
        Card(name: "SOL", value: 23.45, imageSymbol:  Image("solana"), marketCap: "MarketCap 43.75$B", volume: "Volume 24h 31,60$B", priceChangePercentage24h: "0,56"),
        Card(name: "ETH", value: 23.45, imageSymbol: Image("ethereum"), marketCap: "MarketCap 43.75$B", volume: "Volume 24h 31,60$B", priceChangePercentage24h: "+0,56")
    ]
}



