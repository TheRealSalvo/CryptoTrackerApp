
import SwiftUI

struct CardModel: Identifiable {
    var id = UUID()
    
    var Name: String
    var Value: Double
    var ImageSymbol: Image
    var MarketCap: String
    var Volume: String
    var priceChangePercentage24h: String
}



