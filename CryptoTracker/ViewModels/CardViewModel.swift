import SwiftUI
class CardViewModel {
    var cards : [Card] = []
    
    init(coins: [MarketData]){
        for coin in coins {
            cards.append(Card(coin: coin))
        }
    }
}



