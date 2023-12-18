import SwiftUI

struct CardView: View {
    let card: Card
    
    var body: some View {
            
            VStack(alignment: .leading){
                HStack {
                    AsyncImage(url: URL(string: card.imageURL)){ image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                    } placeholder: {
                        ProgressView()
                    }
                    .clipShape(Circle())
                        
                    Text(card.name)
                        .font(.title)
                        .bold()
                        .foregroundStyle(Color.white)
                    Spacer()
                    Text(formatPriceChange(card.priceChangePercentage24h))
                        .foregroundStyle(Color.green)
                    Image(systemName: "triangle.fill")
                        .foregroundStyle(Color.green)
                }
                
                Spacer()
                
                HStack {
                    VStack(alignment:.leading) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(formatMarketCap(card.marketCap))
                                Text(formatVolume(card.volume))
                            }
                            //.foregroundStyle(Color.gray)
                            // swapped this to secondary so that it adapts to dark and high contrast modes
                            .foregroundStyle(Color.secondary)
                            //added a font size
                            .font(.caption)
                            .bold()
                            Spacer()
                            
                            if(card.sparkline.count > 0){
                                ChartView(of: card.sparkline)
                                    .frame(maxWidth: 100)
                            }
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .leading) {
                            Text("\(card.value)$")
                                .foregroundStyle(Color.white)
                                .font(.title)
                        }
                    }
                    Spacer()
             
                }
            }
            .frame(maxHeight: 150)
            .padding()
        //    .background(.banana)
            .background(Color(UIColor.systemGray2))
            .cornerRadius(20)
            .padding()
            .accessibilityElement()
            .accessibilityLabel("Coin information card")
            .accessibilityValue(String("Coin \(card.name), price \(card.value), 24 hour price change \(card.priceChangePercentage24h). Market cap \(card.marketCap), 24 hour volume \(card.volume)."))
        //add currency to voiceover
        }
    
    private func formatMarketCap(_ marketCap: Double) -> String {
        if marketCap >= 1_000_000_000 {
            return String(format: "MarketCap: $%.01fB", marketCap / 1_000_000_000)
        } else if marketCap >= 1_000_000 {
            return String(format: "MarketCap: $%.01fM", marketCap / 1_000_000)
        } else {
            return "MarketCap: N/A"
        }
    }
    
    private func formatVolume(_ volume: Double) -> String {
        if volume >= 1_000_000_000 {
            return String(format: "Volume 24h: $%.01fB", volume / 1_000_000_000)
        } else if volume >= 1_000_000 {
            return String(format: "Volume 24h: $%.01fM", volume / 1_000_000)
        } else {
            return "Volume 24h: N/A"
        }
    }
    
    private func formatPriceChange(_ priceChange: Double) -> String {
        return String(format: "%.2f%%", priceChange)
    }
}

#Preview {
    let card = Card(name: "BTC", value: 24.4, imageSymbol: "bitcoin", marketCap: 837_000_000_000, volume:  837_000_000_000, priceChangePercentage24h: 0.56, sparkline: [0, 3])
    return CardView(card: card)
}

