//
//  ContentView.swift
//  CryptoTracker
//
//  Created by Salvatore Attanasio on 11/12/23.
//

import SwiftUI
import Charts

struct ContentView: View {
    
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
                    if let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String{
                        Text("API_KEY: \(apiKey)").font(.footnote)
                    }
                }
            }
            
            .padding()
            
            
            if(viewModel.isReady){
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
                }
                .refreshable {
                    viewModel.updateCoins()
                }
            }
        }
        .onAppear {
            viewModel.updateCoins()
        }
    }
}

#Preview {
    ContentView(viewModel: MarketOverviewViewModel())
}

