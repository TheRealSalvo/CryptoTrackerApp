import SwiftUI

struct CardView: View {
    let card: Card
    
    var body: some View {
            
            VStack(alignment: .leading){
                HStack {
                    card.imageSymbol
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50)
                        .frame(height: 50)
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
                            .foregroundStyle(Color.gray)
                            .bold()
                            Spacer()
                            
                            ChartView(of: card.sparkline)
                               .frame(maxWidth: 100)
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
            .background(.banana)
            .cornerRadius(20)
            .padding()
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

// Preview
struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        let card = Card(name: "BTC", value: 24.4, imageSymbol: Image("bitcoin"), marketCap: 837_000_000_000, volume:  837_000_000_000, priceChangePercentage24h: 0.56, sparkline: [0, 3])
        CardView(card: card)
    }
}

