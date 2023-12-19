
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
    
    @State private var showAlert : Bool = false
    @State private var alertDescription : String = ""
    
    @State private var showSheet = false
    @State private var searchText = ""
    
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
                LazyVStack {
                    ForEach(filteredCoins) { coin in
                        let data = viewModel.getCoinMarketData(of: coin.name)
                        
                        if let data = data {
                            NavigationLink{
                                DetailView(detailModel: data)
                            } label: {
                                CardView(card: Card(coin: data))
                                    .contextMenu(menuItems: {
                                        Button(action: {
                                            removeFromFavourite(coin: coin)
                                        }, label: {
                                            Text("Remove from Favourites")
                                        })
                                        
                                    })
                            }
                        }
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
    }
        .searchable(text: $searchText)
        .refreshable {
            Task{
                do{
                    try await viewModel.updateCoins()
                }catch{
                    alertDescription = error.localizedDescription
                    showAlert.toggle()
                }
            }
        }
        .alert(
            "Error",
            isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("\(alertDescription)")
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
