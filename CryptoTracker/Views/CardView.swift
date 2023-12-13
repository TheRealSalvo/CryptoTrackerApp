//
//  CardView.swift
//  CryptoTracker
//
//  Created by SHOHJAHON on 13/12/23.
//

import SwiftUI

struct CardView: View {
    let card: CardModel
    
    var body: some View {
            
            VStack(alignment: .leading){
                HStack {
                    card.ImageSymbol
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50)
                        .frame(height: 50)
                    Text(card.Name)
                        .font(.title)
                        .bold()
                        .foregroundStyle(Color.white)
                    Spacer()
                    Text(card.priceChangePercentage24h)
                        .foregroundStyle(Color.green)
                    Image(systemName: "triangle.fill")
                        .foregroundStyle(Color.green)
                }
                
                Spacer()
                
                HStack {
                    VStack(alignment:.leading) {
                        HStack {
                            VStack(alignment: .leading) {
                               
                                Text(card.MarketCap)
                                Text(card.Volume)
                                
                            }   .foregroundStyle(Color.gray)
                                .bold()
                            
                            Spacer()
                            
                            ChartView(of: [46,90,45,34,32,11])
                                .chartXAxis(.hidden)
                                .chartYAxis(.hidden)
                               .frame(maxWidth: 100)
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .leading) {
                            Text("\(card.Value)$")
                                .foregroundStyle(Color.white)
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        }
                    }
                    Spacer()
             
                }
            }
            .frame(maxHeight: 150)
            .padding()
            .background(.banana)
            .cornerRadius(10)
            .padding()
        }
    }


#Preview {
    let card = CardModel(Name: "BTC", Value:23.45 , ImageSymbol: Image("bitcoin"), MarketCap: "MarketCap 43.75$B", Volume: "Volume 24h 31,60$B", priceChangePercentage24h: "+0,56")
    return CardView(card: card)
}
