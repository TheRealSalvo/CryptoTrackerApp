//
//  CoinsListView.swift
//  CryptoTracker
//
//  Created by Salvatore Attanasio on 14/12/23.
//

import SwiftUI
import SwiftData

struct AllCoinsListView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    @ObservedObject var viewModel: MarketOverviewViewModel
    
    @State private var searchText = ""
    
    var list: some View{
        List(viewModel.coins) { coin in
            var added : Bool = false
            HStack(alignment: .center, content: {
                Image(coin.image)
                
                VStack(alignment: .leading){
                    Text(coin.name)
                    Text(String(coin.currentPrice))
                }
                Text("\(coin.priceChangePercentage24h)")
                if(coin.sparkline != nil){
                    ChartView(of: coin.sparkline!.price)
                        .chartXAxis(.hidden)
                        .chartYAxis(.hidden)
                }
                Button(action: {
                    addToFavorites(coin: coin.name)
                    added.toggle()
                }, label: {
                    Image(systemName: "plus")
                })
            })
        }
    }
    
    var body: some View {
        NavigationStack {
            list
            .navigationTitle("All Coins")
           
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        HStack{
                            Image(systemName: "chevron.left")
                                .resizable()
                            Text("Back")
                        }
                    }
                }
            }
        }
        .searchable(text: $searchText)
    }
    
    func addToFavorites (coin: String){
        let favorite = FavoriteCoin(name: coin)
        modelContext.insert(favorite)

        //to debug that we are putting items in to the list correctly
        print("Current watchlist is")
        let fetchDescriptor = FetchDescriptor<FavoriteCoin>()
        let favorites = try! modelContext.fetch(fetchDescriptor)
        for coin in favorites {
            print(coin.name)
        }
    }
    
    func addToWatchlist (coin: String){
        let favorite = WatchlistCoin(name: coin)
        modelContext.insert(favorite)
        //to debug that we are putting items in to the list correctly

        print("Current watchlist is")
        let fetchDescriptor2 = FetchDescriptor<WatchlistCoin>()
        let watchlist = try! modelContext.fetch(fetchDescriptor2)
        for coin in watchlist {
            print(coin.name)
        }

    }
}

#Preview {
    AllCoinsListView(viewModel: MarketOverviewViewModel())
}
