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
    
    @State var query : [AnyObject]
    
    var function: (String)->Void
    
    var list: some View{
        List(viewModel.coins) { coin in
            HStack(alignment: .center, content: {
                AsyncImage(url: URL(string: coin.image)){ image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                
                VStack(alignment: .leading){
                    Text(coin.name)
                    Text(String(coin.currentPrice))
                }
                Text("\(coin.priceChangePercentage24h)")
                if(coin.sparkline != nil){
                    ChartView(of: coin.sparkline!.price)
                }
                Button(action: {
                    function(coin.name)
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
}

#Preview {
    AllCoinsListView(viewModel: MarketOverviewViewModel(), query: [], function: {_ in print("test")})
}
