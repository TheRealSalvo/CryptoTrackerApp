//
//  ContentView.swift
//  CryptoTracker
//
//  Created by Salvatore Attanasio on 11/12/23.
//

import SwiftUI
import Charts

struct ContentView: View {
    
    @ObservedObject var viewModel: MarketOverviewVewModel

    var body: some View {
        VStack {
            HStack{
                Image(systemName: "bitcoinsign.circle.fill")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                VStack{
                    Text("Crypto Tracker: NC2")
                    Text("Powered by CoinGecko").font(.footnote)
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
                            Chart(coin.sparkline!.price, id: \.self) {
                                    LineMark(
                                        x: .value("Month", coin.sparkline!.price.firstIndex(of: $0) ?? 0),
                                        y: .value("Price", $0)
                                    )
                                }
    //                        Sparkline(points: coin.sparkline?.price ?? prices).path(in: CGRect(x: 0, y: 0, width: 60, height: 50))
    //                            .stroke(.gray, lineWidth: 1.0)
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
    ContentView(viewModel: MarketOverviewVewModel())
}

//struct MarketOverviewView_Previews: PreviewProvider {
//    static var previews: some View {
//
//        let viewModel = MarketOverviewVewModel()
//
//        viewModel.coins = [
//            MarketData(
//                id: "bitcoin",
//                symbol: "btc",
//                name: "Bitcoin",
//                image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
//                currentPrice: 39887.0,
//                marketCap: 782690443079.0,
//                marketCapRank: 1,
//                totalVolume: 25358705984.0,
//                high24h: 40953.0,
//                low24h: 39832.0,
//                priceChange24h: -1058.582579497248,
//                priceChangePercentage24h: -2.58537,
//                marketCapChange24h: -15875580666.482422,
//                marketCapChangePercentage24h: -1.98801,
//                circulatingSupply: 19563537.0,
//                totalSupply: 21000000.0,
//                maxSupply: 21000000.0,
//                ath: 59717.0,
//                athChangePercentage: -33.00595,
//                athDate: "2021-11-10T14:24:11.849Z",
//                atl: 51.3,
//                atlChangePercentage: 77888.23046,
//                atlDate: "2013-07-05T00:00:00.000Z",
//                lastUpdated: "2023-12-07T19:47:58.627Z"
//            )
//        ]
//
//        return Group {
//            MarketOverviewView(viewModel: viewModel)
//        }
//    }


