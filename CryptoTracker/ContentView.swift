//
//  ContentView.swift
//  CryptoTracker
//
//  Created by Salvatore Attanasio on 11/12/23.
//

import SwiftUI
import Charts
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    
    @ObservedObject var viewModel: MarketOverviewViewModel

    var body: some View {
        VStack {
            HStack{
                Image(systemName: "bitcoinsign.circle.fill")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                VStack{
                    Text("Crypto Tracker: NC2")
                    Text("Powered by CoinGecko").font(.footnote)
                }
            }
            .padding()
            
            List(viewModel.coins) { coin in
                NavigationLink {
                    //TO DO insert a link to the coin detail view
                } label: {
                    HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, content: {
                        Text(coin.name)
                        Text(String(coin.currentPrice))
                        Spacer()
                        if(coin.sparkline != nil){
                            ChartView(of: coin.sparkline!.price)
                                .chartXAxis(.hidden)
                        }
                    })
                }
                .swipeActions{
                    Button{
                        addToFavorites(coin: coin.name)
                    } label: {
                        Label("Favorite", systemImage: "star.fill")
                    }
                    .tint(.yellow)
                    Button{
                        addToWatchlist(coin: coin.name)
                    } label: {
                        Label("Add to Watchlist", systemImage: "eyeglasses")
                    }
                    .tint(.green)
                }
            }
            .refreshable {
                viewModel.updateCoins()
            }
        }
        .onAppear {
            viewModel.updateCoins()
        }
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
    ContentView(viewModel: MarketOverviewViewModel())
}

