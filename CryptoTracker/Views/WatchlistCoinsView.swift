//
//  WatchlistCoinsView.swift
//  CryptoTracker
//
//  Created by Salvatore Attanasio on 15/12/23.
//

import SwiftUI

import SwiftUI
import SwiftData

struct WatchlistCoinsView: View {
    @Environment(\.modelContext) var modelContext
    @ObservedObject var viewModel: MarketOverviewViewModel
    
    @Query private var watchlistCoins: [WatchlistCoin] = []
    
    @State private var showSheet = false
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                
                LazyVGrid(columns: [GridItem(.fixed(360))], spacing: 7) {
                    ForEach(watchlistCoins) { coin in
                        let data = viewModel.getCoinMarketData(of: coin.name)
                        
                        CardView(card: Card(coin: data!))
                            .contextMenu(menuItems: {
                                Button(action: {
                                    removeFromWatchlist(coin: coin)
                                }, label: {
                                    Text("Remove from Watchlist")
                                })
                            })
                    }
                }
            }
            .scrollClipDisabled()
            .padding()
            .navigationTitle("Watchlist")
           
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showSheet.toggle()
                    } label: {
                        Image(systemName:"plus.circle")
                           
                    }
                    .sheet(isPresented: $showSheet) {
                        AllCoinsListView(viewModel: self.viewModel, function: addToWatchlist)
                    }
                }
            }
        }.searchable(text: $searchText)
    }
    
    func addToWatchlist(coin: String){
        let newWatchedCoin = WatchlistCoin(name: coin)
        print("Added to watchlist: \(coin)")
        modelContext.insert(newWatchedCoin)
        
        print("Current watchlist is")
                let fetchDescriptor = FetchDescriptor<WatchlistCoin>()
                let watched = try! modelContext.fetch(fetchDescriptor)
                for coin in watched {
                    print(coin.name)
                }
    }
    
    func removeFromWatchlist(coin: WatchlistCoin){
        modelContext.delete(coin)
    }
}


#Preview {
    WatchlistCoinsView(
        viewModel: MarketOverviewViewModel()
    )
}
