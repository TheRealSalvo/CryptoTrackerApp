//
//  SplashScreenView.swift
//  CryptoTracker
//
//  Created by Salvatore Attanasio on 14/12/23.
//

import SwiftUI

struct SplashScreenView: View {
    @ObservedObject var marketVM: MarketOverviewViewModel
    
    @State private var showAlert : Bool = false
    @State private var alertDescription : String = ""
    
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
                    Image("CoinGeckoLogo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 200)
                    
                    HStack{
                        Text("Fetching data from server...")
                            .font(.custom("orange", fixedSize: 10))
                        ProgressView()
                    }.padding(.top)
                }
            } else {
                TabView{
                    FavoriteCoinsView(viewModel: marketVM)
                        .tabItem { 
                            HStack{
                                Image(systemName: "star.fill")
                                Text("Favorites")
                                }
                            }
                    WatchlistCoinsView(viewModel: marketVM)
                        .tabItem { 
                            HStack{
                                Image(systemName: "list.bullet.rectangle.portrait.fill")
                                Text("Watchlist")
                            }
                        }
                }
            }
        }
        .onAppear(){
            Task{
                do{
                    try await marketVM.updateCoins()
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
}

#Preview {
    SplashScreenView(marketVM: MarketOverviewViewModel())
}
