
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
    
    //@Query(sort: \FavoriteCoin.id, order: .reverse)
    @Query private var favouriteCoins: [FavoriteCoin] = []
    
    @State private var showSheet = false
    @State private var searchText = ""
    
    //CHECK IF I USEED / NEEDED THIS
    let alertTitle: String = "Error"
    
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
                        showSheet.toggle()
                    } label: {
                        Image(systemName:"plus.circle")
                           
                    }
                    .sheet(isPresented: $showSheet) {
                        AllCoinsListView(viewModel: self.viewModel)
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
                        Text("Error \(String(describing: viewModel.alertContent)) when updating data")
                        }
    }
    
    func loadFavourites(){
        //to debug that we are putting items in to the list correctly
        print("Current watchlist is")
        let fetchDescriptor = FetchDescriptor<FavoriteCoin>()
        let favorites = try! modelContext.fetch(fetchDescriptor)
        for coin in favorites {
            print(coin.name)
        }

    }
}


#Preview {
    FavoriteCoinsView(
        viewModel: MarketOverviewViewModel()
    )
}

