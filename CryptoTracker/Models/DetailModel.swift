import Foundation

import SwiftUI

struct DetailModel: Identifiable {

    var id = UUID()
    var name : String
    var acronym : String
    var symbol : String
    var currentPrice : Double
    var priceChangePercentage: String
    var ranking : Int
    var high24h : Double
    var low24h : Double
    var highAlltime : Double
    var releaseDate : String
    
    
}
