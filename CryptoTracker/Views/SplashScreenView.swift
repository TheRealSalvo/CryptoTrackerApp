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
            if marketVM.coins.isEmpty {
                VStack{
                    Image("AppIcon")
                        .resizable()
                        .frame(maxWidth: 200, maxHeight: 200)
                    Text("Powered by")
                    Image("CoinGeckoLogoWithDarkText")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 200)
                    Text("Fetching data from server...")
                        .padding(.top)
                }
            } else {
                FavoriteCoinsView(viewModel: marketVM)
            }
        }
    }
}

#Preview {
    SplashScreenView(marketVM: MarketOverviewViewModel())
}
