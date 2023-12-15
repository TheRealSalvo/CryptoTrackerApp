//
//  SplashScreenView.swift
//  CryptoTracker
//
//  Created by Salvatore Attanasio on 14/12/23.
//

import SwiftUI

struct SplashScreenView: View {
    @ObservedObject var marketVM: MarketOverviewViewModel
    
    var body: some View {
        ZStack{
            if (marketVM.coins.isEmpty){
                VStack(alignment: .center){
                    Image("inAppIcon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 200)
                        .padding(.bottom, 40)
                    Text("Powered by")
                    Image("CoinGeckoLogoWithDarkText")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 200)
                    HStack{
                        Text("Fetching data from server...")
                            .font(.title3)
                        ProgressView()
                    }.padding(.top)
                }
            } else {
                TabView{
                    FavoriteCoinsView(viewModel: marketVM)
                        .tabItem { Text("Favorites") }
                    WatchlistCoinsView(viewModel: marketVM)
                        .tabItem { Text("Watchlist") }
                }
            }
        }
    }
}

#Preview {
    SplashScreenView(marketVM: MarketOverviewViewModel())
}
