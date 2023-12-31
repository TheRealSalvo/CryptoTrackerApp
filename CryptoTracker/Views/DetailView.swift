
import SwiftUI
struct DetailView: View {
    @State private var selectedColorIndex = 0
    let detailModel: MarketData
    
    private let dateFormatter = ISO8601DateFormatter()
    
    init(detailModel: MarketData){
        self.detailModel = detailModel
        dateFormatter.formatOptions.insert(.withFractionalSeconds)
    }
    
    var body: some View {
            VStack(alignment: .leading, spacing: 0) {
                Divider()
                HStack {
                    HStack(spacing: 16) {
                        AsyncImage(url: URL(string: detailModel.image)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 48, height: 48)
                                .clipShape(Circle())
                        } placeholder: {
                            ProgressView()
                        }
                        
                        Text(detailModel.name)
                            .font(.title)
                            .bold()
                            .foregroundColor(.gray)
                        
                        Spacer()
                    }
                    VStack(alignment: .trailing){
                        Text(String(detailModel.currentPrice))
                            .font(.title3)
                            .fontWeight(.bold)
                        
                        CustomText(detailModel.priceChangePercentage24h, textType: .priceChangePercentage)
                            .font(.title3)
                            .foregroundColor(detailModel.priceChangePercentage24h > 0 ? .green : .red)
                            .fontWeight(.bold)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                Rectangle()
                    .foregroundStyle(.foreground.opacity(0.175))
                    .frame(height:0.5)
                    .frame(maxWidth: .infinity)
            }
            .padding(0)
            ScrollView(.vertical) {
                if(detailModel.sparkline != nil){
                    VStack {
                        ChartView(of: detailModel.sparkline!.price, scaleFactor: 1.02)
                            .frame(height: 200)
                        Divider()
                    }
                }
                VStack(alignment: .leading, spacing: 16) {
                    VStack(alignment: .leading) {
                        HStack {
                            Text(detailModel.name + " " + "Informations")
                                .font(.title)
                                .bold()
                            Spacer()
                        }
                        .padding(.bottom,10)
                        HStack {
                            Text("Last Updated")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .textCase(.uppercase)
                                .kerning(1.5)
                                .foregroundStyle(.foreground.opacity(0.5))
                            Spacer()
                        }
                        
                        
                        let date = dateFormatter.date(from: detailModel.lastUpdated)
                        if (date != nil){
                            Text(date!, style: .date)
                                .fontWeight(.bold)
                        }else{
                            Text("N/A")
                                .fontWeight(.bold)
                        }
                    }
                    
                    VStack(spacing: 16) {
                        DetailItemRow("Ranking", value: detailModel.marketCapRank)
                        DetailItemRow("ATH", value: detailModel.ath)
                        
                        Divider()
                        
                        VStack(alignment: .leading) {
                            HStack {
                                Text("ATH Date")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .textCase(.uppercase)
                                    .kerning(1.0)
                                    .foregroundStyle(.foreground.opacity(0.5))
                                Spacer()
                            }
                            
                            
                            let date = dateFormatter.date(from: detailModel.athDate)
                            if (date != nil){
                                Text(date!, style: .date)
                                    .fontWeight(.bold)
                            }else{
                                Text("N/A")
                                    .fontWeight(.bold)
                            }
                        }
                        
                        DetailItemRow("Higher price (24h)", value: detailModel.high24h)
                        DetailItemRow("Lowest price (24h)", value: detailModel.low24h)
                        DetailItemRow("Circulating Supply", value: detailModel.circulatingSupply)
                    }
                    
                }
                .padding()
            }
            .padding(0)
            .navigationBarTitleDisplayMode(.inline)
//            .toolbar { // TODO: make it work
//                ToolbarItemGroup(placement:.navigationBarTrailing)
//                {
//                    Button {
//                        
//                    } label: {
//                        Label("Add to Favorites", systemImage: "star.fill")
//                    }
//                }
//            }
        }
    }

#Preview {
    let sparkline = [
        43659.830608952616,
        43794.25619153226,
        43633.412709203716,
        43937.59163050896,
        43819.98586201575,
        43832.78035618881,
        43734.95670481345,
        43871.06803558629,
        43911.84414986522,
        44304.29854895467,
        44385.97528580486,
        44252.83509521942,
        44158.48119026304,
        44198.705818343165,
        44108.697502579984,
        44196.30077985671,
        44154.298824625366,
        44239.39526772252,
        44290.2632794866,
        44229.141019371375,
        44204.4580785644,
        43840.60632056117,
        43847.66351672282,
        43853.63342948888,
        43824.94502243738,
        43899.368140170685,
        44006.937503718174,
        43949.441930030014,
        44117.99323780744,
        44017.79837995913,
        43944.03423047422,
        43965.949557801694,
        43945.693569809504,
        43980.53017046564,
        44006.302674216204,
        43908.53000269771,
        43714.93535399452,
        43791.11048243972,
        43802.145000795754,
        43797.215945807526,
        43845.42419301062,
        43939.24408548624,
        43894.827602213125,
        43917.5199241797,
        43968.39740026597,
        43787.873300938925,
        43634.41192705681,
        43715.96053031301,
        43737.59599352967,
        43812.044576847926,
        43832.213030611165,
        43864.44652833788,
        43935.43898772248,
        43805.59128814079,
        43792.2242364665,
        43864.742796961626,
        43798.29205483033,
        43967.496154161665,
        43812.09560255007,
        43783.921845319455,
        43757.959937619176,
        43645.41521066105,
        43266.820817984015,
        41977.79580342069,
        42335.19287326501,
        42170.359240455335,
        41963.918435869426,
        41983.16618652562,
        42130.029010755534,
        42203.07612417308,
        42289.044855997876,
        42384.16182852714,
        42345.67055988128,
        42211.75130516923,
        42070.62720658794,
        41898.11604074295,
        41862.78867550699,
        41678.24259803585,
        41332.88950352128,
        40983.403277832826,
        40753.09799675056,
        40819.09242130922,
        41090.42517461659,
        41259.3097335054,
        41262.42774346128,
        41657.03627972297,
        41650.24315559637,
        41841.00358261786,
        41736.848805059926,
        41515.07283688436,
        41523.985629395705,
        41651.730244341976,
        42013.95727808587,
        42026.30464430417,
        41842.45594603396,
        41772.858482883326,
        41609.024084227676,
        41865.28359097863,
        41862.05316636862,
        41467.71365603181,
        41298.866947463066,
        41301.18543434075,
        40720.052615882276,
        41251.16516288981,
        41083.08102526008,
        41234.11289620644,
        41066.78005858458,
        41243.529922413894,
        41450.819387377436,
        41402.20524534755,
        41077.682664111395,
        40987.371856768616,
        40804.87516728444,
        40892.5456601397,
        40961.11667003693,
        40886.84969702335,
        41108.21612991579,
        41210.73220951229,
        41202.76530861262,
        41075.82122712554,
        40959.7745311822,
        41124.5699534689,
        41444.99746245883,
        41425.82037999901,
        41869.404129598704,
        41844.2458858634,
        42091.78246722764,
        42074.91076481174,
        42770.01584143941,
        42856.79358974412,
        43038.42897688392,
        43044.914433991085,
        42885.34413554673,
        42771.9634610874,
        42851.56536198936,
        42782.21089895684,
        42703.38112158031,
        42723.860398772296,
        42766.04600099997,
        42960.06086336163,
        42902.33179390111,
        42797.25427858573,
        42913.54272252713,
        42977.850332594106,
        43199.21674485783,
        43109.29539903041,
        42600.47961294108,
        42526.25713180226,
        42414.76106217256,
        42608.2753512864,
        43259.13740775674,
        42842.611379969756,
        43108.57999753598,
        42906.92767090652,
        42927.05147686873,
        43088.719481125474,
        43032.27206078472,
        42905.33362930727,
        42980.92442700977,
        42927.963067221244,
        42816.15591306325,
        42790.78088450482,
        42633.83369701004,
        42555.978932492915,
        42650.56697586513,
        42805.507827933056,
        42818.7601345539,
        42842.818350832946
      ]
    
    return DetailView(detailModel:
                MarketData(
                    id: "bitcoin",
                    symbol: "btc",
                    name: "Bitcoin",
                    image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
                    currentPrice: 42618,
                    marketCap: 835242681242,
                    marketCapRank: 1,
                    totalVolume: 18359131042,
                    high24h: 43329,
                    low24h: 42068,
                    priceChange24h: -440.32774697641435,
                    priceChangePercentage24h: 0.456,
                    marketCapChange24h: -10459392146.42041,
                    marketCapChangePercentage24h: -1.23677,
                    circulatingSupply: 0.454,
                    totalSupply: 21000000,
                    maxSupply: 21000000,
                    ath: 69045,
                    athChangePercentage: -38.26969,
                    athDate: "2021-11-10T14:24:11.849Z",
                    atl: 0.456,
                    atlChangePercentage: 0.456,
                    atlDate: "",
                    lastUpdated: "2023-12-15T13:00:13.478Z",
                    sparkline: MarketData.Sparkline(price: sparkline)
                )
        )
}
