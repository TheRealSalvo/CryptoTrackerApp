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
                    
                    if card.priceChangePercentage24h < 0.0 {
                        CustomText(card.priceChangePercentage24h, textType: .priceChangePercentage)
                            .foregroundStyle(Color.red)
                        Image(systemName: "triangle.fill").rotationEffect(.degrees(180))
                            .foregroundStyle(Color.red)
                    } else {
                        CustomText(card.priceChangePercentage24h, textType: .priceChangePercentage)
                            .foregroundStyle(Color.green)
                        Image(systemName: "triangle.fill")
                            .foregroundStyle(Color.green)
                    }
                }
                
                Spacer()
                
                HStack {
                    VStack(alignment:.leading) {
                        HStack {
                            VStack(alignment: .leading) {
                                CustomText(card.marketCap, textType: .marketCap)
                                CustomText(card.volume, textType: .volume)
                            }
                            .foregroundStyle(Color.secondary)
                            .font(.caption)
                            .bold()
                        }
                        
                        Spacer()
                        
                        CustomText(card.value, textType: .currency)
                            .foregroundStyle(Color.white)
                            .font(.title)
                    }
                    .padding(.trailing, 10)
                    if(card.sparkline.count > 0){
                        ChartView(of: card.sparkline)
                    }
             
                }
            }
            .frame(maxHeight: 150)
            .padding()
            .background(Color(UIColor.systemGray2))
            .cornerRadius(20)
            .padding()
            .accessibilityElement()
            .accessibilityLabel("Coin information")
            .accessibilityValue(String("\(card.name), price \(card.value), 24 hour price change \(card.priceChangePercentage24h). Market cap \(card.marketCap), total volume \(card.volume)."))
        //add currency to voiceover
        }
}

#Preview {
    let card = Card(name: "BTC", value: 24.4, imageSymbol: "bitcoin", marketCap: 837_000_000_000, volume:  837_000_000_000, priceChangePercentage24h: 0.56, sparkline: [0, 3])
    return CardView(card: card)
}

