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
        .alert(
            "Error",
            isPresented: $marketVM.showAPIAlert) {
                    Button("OK", role: .cancel) { }
                    } message: {
                        Text("Error \(String(describing: marketVM.alertContentString))")
                        }
    }
}

#Preview {
    SplashScreenView(marketVM: MarketOverviewViewModel())
}
