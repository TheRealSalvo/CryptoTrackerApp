
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
    
    @State private var showAlert : Bool = false
    @State private var alertDescription : String = ""
    
    @State private var showSheet = false
    @State private var searchText = ""
    
    // Computed property to filter favorite coins based on search text
    private var filteredCoins: [FavoriteCoin] {
        if searchText.isEmpty {
            return favouriteCoins
        } else {
            return favouriteCoins.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }

    var body: some View {
        
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 16) {
                    ForEach(filteredCoins) { coin in
                        let data = viewModel.getCoinMarketData(of: coin.name)
                        
                        if let data = data {
                            NavigationLink{
                                DetailView(detailModel: data)
                            } label: {
                                CardView(card: Card(coin: data))
                                    .contextMenu(menuItems: {
                                            Button(role: .destructive, action: {
                                                removeFromFavourite(coin: coin)
                                            }, label: {
                                                Label("Remove from Favourites", systemImage: "")
                                            })
                                        })
                            }
                        }
                    }
                }
                .padding(.horizontal,16)
            }
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
                    AllCoinsListView(viewModel: self.viewModel, function: addToFavorites)
                }
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
