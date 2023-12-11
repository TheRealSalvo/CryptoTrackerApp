//
//  ContentView.swift
//  CryptoTracker
//
//  Created by Salvatore Attanasio on 11/12/23.
//

import SwiftUI

var prices: [Double] = [1.0, 2.5, 3.7, 4.2, 5.8, 6.4, 7.1, 8.9, 9.3, 10.6, 11.2, -1.0, 13.4, 14.8, 15.2, 16.6, 17.3, 18.9, 19.5, 20.0]

struct Sparkline: Shape{
    var points : [Double]
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let sPoints = points.sorted { $0 < $1}
        let maxYCoord = sPoints.map {$0}.max() ?? 1
        let maxXCoord = 7.0
        let xScale: CGFloat = rect.maxX / CGFloat(maxXCoord)
        let yScale: CGFloat = rect.maxY / CGFloat(maxYCoord)
        var i = 0
        let x_increment = maxXCoord / Double(points.count)
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY - (CGFloat(points[0]) * yScale)) )
        for item in points {
            path.addLine(to: CGPoint(x: rect.minX + (Double(i) * x_increment * xScale), y: rect.maxY - (item * yScale) ))
            i = i+1
        }
        return path
    }
}


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
            
            if(viewModel.coins != nil){
                Sparkline(points: viewModel.coins!.first!.sparkline!.price)
                    .path(in: CGRect(x: 0, y: 100, width: 250.0, height: 100.0))
                    .stroke(.black, lineWidth: 10.0)
                
                List(viewModel.coins!) { coin in
                    NavigationLink {
                        //TO DO insert a link to the coin detail view
                    } label: {
                        HStack{
                            Text(coin.name)
                            Text(String(coin.currentPrice))
                            //Text(String((coin.sparkline?.price[0])!)) //jsut to prove we were accessing the data
                        }
                    }
                }
            }
        }
        .onAppear {
            viewModel.updateCoins()
        }
    }
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


