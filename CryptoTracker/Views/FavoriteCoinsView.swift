
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
    
    //CHECK IF I USEED / NEEDED THIS
    let alertTitle: String = "Api error"
    
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
                                Button(action: {
                                    removeFromFavourite(coin: coin)
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
                    .sheet(isPresented: $showSheet) {
                        AllCoinsListView(viewModel: self.viewModel, function: addToFavorites)
                    }
                }
            }
        }
        .searchable(text: $searchText)
        .refreshable {
                viewModel.updateCoins()
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
    
    func removeFromFavourite(coin: FavoriteCoin){
        modelContext.delete(coin)
    }
}


#Preview {
    FavoriteCoinsView(
        viewModel: MarketOverviewViewModel()
    )
}

