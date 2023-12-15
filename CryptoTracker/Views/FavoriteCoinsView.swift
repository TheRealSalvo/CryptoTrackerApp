
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
    
    @Query private var favouriteCoins: [FavoriteCoin] = []
    
    @State private var showSheet = false
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                
                LazyVGrid(columns: [GridItem(.fixed(360))], spacing: 7) {
                    ForEach(favouriteCoins) { coin in
                        let data = viewModel.coins.first { viewModelData in
                            viewModelData.name == coin.name
                        }
                        
                        CardView(card: Card(coin: data!))
                            .contextMenu(menuItems: {
                                Text("Remove from Favourites")
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
                        showSheet.toggle()
                    } label: {
                        Image(systemName:"plus.circle")
                           
                    }
                    .sheet(isPresented: $showSheet) {
                        AllCoinsListView(viewModel: self.viewModel)
                    }
                }
            }
        }.searchable(text: $searchText)
    }
}


#Preview {
    FavoriteCoinsView(
        viewModel: MarketOverviewViewModel()
    )
}

