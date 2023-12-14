
import SwiftUI

struct Card: Identifiable {
    var id = UUID()
    
    var name: String
    var value: Double
    var imageSymbol: Image
    var marketCap: String
    var volume: String
    var priceChangePercentage24h: String
}



