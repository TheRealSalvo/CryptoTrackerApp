
//  ContentView.swift
//  Crypto App
//
//  Created by Salvatore Capasso on 11/12/23.
//

import SwiftUI

struct FavoriteCoinsView: View {
    @State private var searchText = ""
   var viewModel : CardViewModel
    
    var body: some View {
       
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                
                LazyVGrid(columns: [GridItem(.fixed(360))], spacing: 7) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card)
                            .contextMenu(menuItems: {
                                Text("Menu Item 1")
                                Text("Menu Item 2")
                                Text("Menu Item 3")
                            })
                        
                        
                    }
                  
                }
            }
            .scrollClipDisabled()
            .padding()
            .navigationTitle("Favourite Coins")
           
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName:"plus.circle")
                           
                    }
                }
            }
        }  .searchable(text: $searchText)
    }
}
    #Preview {
        FavoriteCoinsView(viewModel: CardViewModel(
            coins: [
                MarketData(
                    id: "btc",
                    symbol: "BTC",
                    name: "Bitcoin",
                    image: "bitcoin",
                    currentPrice: 123.45,
                    marketCap: 123.45,
                    marketCapRank: 1,
                    totalVolume: 123.45,
                    high24h: 123.45,
                    low24h: 123.45,
                    priceChange24h: 123.45,
                    priceChangePercentage24h: 123.45,
                    marketCapChange24h: 123.45,
                    marketCapChangePercentage24h: 123.45,
                    circulatingSupply: 123.45,
                    totalSupply: 123.45,
                    maxSupply: 123.45,
                    ath: 123.45,
                    athChangePercentage: 123.45,
                    athDate: "12-12-12",
                    atl: 123.45,
                    atlChangePercentage: 123.45,
                    atlDate: "12-12-12",
                    lastUpdated: "12-12-12",
                    sparkline: MarketData.Sparkline(price: [1,2,3]))
            ]
        ))
    }

