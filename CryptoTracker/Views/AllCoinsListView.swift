import SwiftUI
import SwiftData

struct AllCoinsListView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @ObservedObject var viewModel: MarketOverviewViewModel
    
    @State private var searchText = ""
    @State private var addedCoins: Set<String> = [] // Track added coins
    
    private var filteredCoins: [MarketData] {
        if searchText.isEmpty {
            return viewModel.coins
        } else {
            return viewModel.coins.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var function: (String)->Void
    
    var list: some View {
        List(filteredCoins) { coin in
            HStack(alignment: .center) {
                AsyncImage(url: URL(string: coin.image)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                }
            
            placeholder: {
                    ProgressView()
                }
            .clipShape(Circle())
                
                VStack(alignment: .leading) {
                    Text(coin.symbol)
                        .font(.title)
                        .bold()
                    Text(String(coin.currentPrice))
                }
                
                CustomText(coin.priceChangePercentage24h, textType: .priceChangePercentage)
                
                if coin.sparkline != nil {
                    ChartView(of: coin.sparkline!.price)
                }
                
                Button(action: {
                    if addedCoins.contains(coin.name) {
                        // Remove the coin
                        addedCoins.remove(coin.name)
                    } else {
                        // Add the coin
                        addedCoins.insert(coin.name)
                    }
                    function(coin.name)
                }) {
                    Image(systemName: addedCoins.contains(coin.name) ? "minus.circle.fill" : "plus.circle.fill")
                }
            }
            .accessibilityElement()
            .accessibilityLabel("Coin information")
            .accessibilityValue(String("\(coin.name), price \(coin.currentPrice), 24 hour price change \(coin.priceChangePercentage24h). Market cap \(coin.marketCap), 24 hour volume \(coin.totalVolume)."))
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
                            HStack {
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
    AllCoinsListView(viewModel: MarketOverviewViewModel(), function: {_ in print("test")})
}
