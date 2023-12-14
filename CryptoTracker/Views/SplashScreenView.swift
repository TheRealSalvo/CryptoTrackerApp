//
//  SplashScreenView.swift
//  CryptoTracker
//
//  Created by Salvatore Attanasio on 14/12/23.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var marketVM : MarketOverviewViewModel? = nil
    
    var body: some View {
        ZStack{
            if(isActive){
                ContentView(viewModel: marketVM ?? MarketOverviewViewModel())
            }else{
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
            }
        }.onAppear{
            marketVM = MarketOverviewViewModel()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5){
                withAnimation{
                    self.isActive = true
                }
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
