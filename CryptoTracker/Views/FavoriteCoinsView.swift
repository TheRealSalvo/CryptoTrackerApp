
//  ContentView.swift
//  Crypto App
//
//  Created by Salvatore Capasso on 11/12/23.
//

import SwiftUI
import SwiftData

struct FavoriteCoinsView: View {
    @Environment(\.modelContext) var modelContext
    @ObservedObject var viewModel: MarketOverviewViewModel
    
    @State private var searchText = ""
    
    var body: some View {
       
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                
                LazyVGrid(columns: [GridItem(.fixed(360))], spacing: 7) {
                    ForEach(viewModel.coins) { coin in
                        CardView(card: Card(coin: coin))
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
    FavoriteCoinsView(
        viewModel: MarketOverviewViewModel()
    )
}

