
import SwiftUI
struct DetailView: View {
    @State private var selectedColorIndex = 0
    let detailModel: MarketData
    
    var body: some View {
        
        
        
        NavigationStack {
            
            ScrollView{
                VStack(alignment:.leading, spacing: 4) {
                    
                    Text(detailModel.symbol)
                        .foregroundColor(.gray)
                    
                    
                    HStack {
                        Text(detailModel.image)
                        
                        
                        
                        Text(detailModel.name)
                            .font(.title)
                            .bold()
                            .foregroundColor(.black)
                        
                    }
                    
                    Text(String(detailModel.currentPrice))
                        .font(.title2)
                        .bold()
                    
                    Text(String(detailModel.priceChangePercentage24h))
                        .font(.title2)
                        .foregroundColor(.red)
                        .bold()
                    Rectangle()
                        .frame(width: 360, height: 320)
                    
                    /*    Picker("Favorite Color", selection: $selectedColorIndex, content: {
                     Text("1 hours").tag(0)
                     Text("1 day").tag(1)
                     Text("1 week").tag(2)
                     Text("1 month").tag(3)
                     Text("1 year").tag(4)
                     
                     })
                     .pickerStyle(SegmentedPickerStyle())*/
                }
                .padding(.bottom,30)
                
                
                Text(detailModel.name + " information")
                    .font(.title2)
                    .bold()
                    .padding(.bottom,10)
                HStack {
                    
                    Text("Ranking")
                    
                    Spacer()
                    Text(String(detailModel.marketCapRank))
                    
                } .bold()
                    .padding(.bottom,10)
                
                HStack {
                    Text("ATH")
                    
                    Spacer()
                    Text(String(detailModel.ath))
                    
                } .bold()
                    .padding(.bottom,10)
                HStack {
                    Text("ATH Date ")
                    
                    Spacer()
                    Text(String(detailModel.athDate))
                    
                } .bold()
                    .padding(.bottom,10)
                HStack {
                    Text("Higher price (24h)")
                    Spacer()
                    Text(String(detailModel.high24h))
                }
                .bold()
                .padding(.bottom,10)
                HStack {
                    Text("Lowest price (24h)")
                    
                    Spacer()
                    Text(String(detailModel.low24h))
                    
                } .bold()
                    .padding(.bottom,10)
                HStack {
                    Text("Market cap")
                    
                    Spacer()
                    Text(String(detailModel.marketCap))
                    
                } .bold()
                    .padding(.bottom,10)
                HStack {
                    
                    Text("Circulatingsupply")
                    
                    Spacer()
                    Text(String(detailModel.circulatingSupply))
                    
                } .bold()
                    .padding(.bottom,10)
                HStack {
                    Text("Release date")
                    
                    Spacer()
                    Text(String(detailModel.lastUpdated))
                    
                } .bold()
                
            }
            
            .toolbar(content: {
                
                ToolbarItem(placement:.navigationBarTrailing)
                {
                    
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                    
                        .foregroundColor(.black)
                  
                }
            })
            Spacer()
        }.padding()
        
    }
}

#Preview {
    
    DetailView(detailModel: MarketData(id: "", symbol: "BTC", name: "Bitcoin", image: "bitcoin", currentPrice: 20.45, marketCap: 22.34, marketCapRank: 2, totalVolume: 45.56, high24h: 22.45, low24h: 17.26, priceChange24h: 5.345, priceChangePercentage24h: 0.456, marketCapChange24h: 0.567, marketCapChangePercentage24h: 0.543, circulatingSupply: 0.454, totalSupply: 23.54, maxSupply: 23.54, ath: 45.62, athChangePercentage: 0.456, athDate: "12/01/2016", atl: 0.456, atlChangePercentage: 0.456, atlDate: "", lastUpdated: "16/04/2023", sparkline: nil))
}
