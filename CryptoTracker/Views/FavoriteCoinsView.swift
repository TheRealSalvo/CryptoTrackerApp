
//  ContentView.swift
//  Crypto App
//
//  Created by Salvatore Capasso on 11/12/23.
//

import SwiftUI
import SwiftData

struct FavoriteCoinsView: View {
    @Environment(\.modelContext) var modelContext
    
    @Bindable
    var viewModel: MarketOverviewViewModel
    
    @Query private var favouriteCoins: [FavoriteCoin] = []
    
    @State private var showSheet = false
    @State private var searchText = ""
    
    let alertTitle: String = "Api error"
    
    // Computed property to filter favorite coins based on search text
    private var filteredCoins: [MergeData] {
        let coins = if searchText.isEmpty {
            favouriteCoins
        } else {
            favouriteCoins.filter { $0.name.lowercased().contains(searchText.lowercased())
            }
        }
        return coins.filter { data in
            viewModel.coins.contains { coin in coin.name == data.name }
        }.map { coin in MergeData(coin,viewModel.coins.first { $0.name == coin.name }!) }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                // Use the filtered list here
                ForEach(filteredCoins) { merge in
                    NavigationLink{
                        DetailView(detailModel: merge.data)
                    } label: {
                        CardView(card: Card(coin: merge.data))
                            .contextMenu(menuItems: {
                                Button(action: {
                                    removeFromFavourite(coin: merge.coin)
                                }, label: {
                                    Text("Remove from Favourites")
                                })
                                
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
                    .accessibilityLabel("Add coin to favourites")
                    .sheet(isPresented: $showSheet) {
                        AllCoinsListView(function: addToFavorites)
                    }
                }
                
            }
            .searchable(text: $searchText)
            .refreshable {
                viewModel.updateCoins()
            }
        }
        .alert(
            "Error",
            isPresented: $viewModel.showAPIAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("Error \(String(describing: viewModel.alertContentString))")
            }
    }
    
    func addToFavorites (coin: String){
        let newFavoriteCoin = FavoriteCoin(name: coin)
        modelContext.insert(newFavoriteCoin)
    }
    
    func removeFromFavourite(coin: FavoriteCoin) {
        modelContext.delete(coin)
    }
}


#Preview {
    FavoriteCoinsView(
        viewModel: MarketOverviewViewModel()
    )
}
