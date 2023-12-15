//
//  CardView.swift
//  CryptoTracker
//
//  Created by SHOHJAHON on 13/12/23.
//

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
                    Text("\(card.priceChangePercentage24h)")
                        .foregroundStyle(Color.green)
                    Image(systemName: "triangle.fill")
                        .foregroundStyle(Color.green)
                }
                
                Spacer()
                
                HStack {
                    VStack(alignment:.leading) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(String(format: "MarketCap: $%.02fB", card.marketCap));
                                Text(String(format: "Volume 24h: $%.01fB", card.volume));
                            }   .foregroundStyle(Color.gray)
                                .bold()
//                            Text(String(format: "Tip Amount: $%.02f", tipAmount))
                            Spacer()
                            
                            ChartView(of: card.sparkline)
                                .chartXAxis(.hidden)
                                .chartYAxis(.hidden)
                               .frame(maxWidth: 100)
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .leading) {
                            Text("\(card.value)$")
                                .foregroundStyle(Color.white)
                                .font(.title)
                            let myDouble = 9999.99
                            let currencyFormatter = NumberFormatter()
                            
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
    }


#Preview {
    let card = Card(name: "BTC", value:24.4, imageSymbol: Image("bitcoin"), marketCap: 43.75, volume: 31.60, priceChangePercentage24h: 0.56)
    return CardView(card: card)
}
