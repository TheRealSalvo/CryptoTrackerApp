
import SwiftUI
struct DetailView: View {
    @State private var selectedColorIndex = 0
    let detailModel: DetailViewModel
    
    var body: some View {
        
        
        NavigationStack {
            
            VStack(alignment:.leading, spacing: 4) {
                
                Text(detailModel.detail[0].acronym)
                    .foregroundColor(.gray)
                
                
                HStack {
                    Image(detailModel.detail[0].symbol)
                        .resizable()
                        .frame(width: 30, height: 30)
                    
                    
                    Text(detailModel.detail[0].name)
                        .font(.title)
                        .bold()
                        .foregroundColor(.black)
                    
                }
                
                Text(String(detailModel.detail[0].currentPrice))
                    .font(.title2)
                    .bold()
                
                Text(String(detailModel.detail[0].priceChangePercentage))
                    .font(.title2)
                    .foregroundColor(.red)
                    .bold()
                Rectangle()
                    .frame(width: 360, height: 320)
                
                Picker("Favorite Color", selection: $selectedColorIndex, content: {
                    Text("1 hours").tag(0)
                    Text("1 day").tag(1)
                    Text("1 week").tag(2)
                    Text("1 month").tag(3)
                    Text("1 year").tag(4)
                    
                })
                .pickerStyle(SegmentedPickerStyle())
            }
            .padding(.bottom,30)
            
         
                Text("Bitcoin information")
                    .font(.title2)
                .bold()
                .padding(.bottom,10)
            HStack {
                
                Text("Ranking")
                    .bold()
                Spacer()
                Text(String(detailModel.detail[0].ranking))
                    .bold()
            }
            .padding(.bottom,10)
            HStack {
                Text("Higher price (All time)")
                
                    .bold()
                Spacer()
                Text(String(detailModel.detail[0].highAlltime))
                    .bold()
                
            }
            .padding(.bottom,10)
            HStack {
                Text("Higher price (24h")
                    .bold()
                Spacer()
                Text(String(detailModel.detail[0].high24h))
                    .bold()
            }
            .padding(.bottom,10)
            HStack {
                Text("Lowest price (24h)")
                    .bold()
                Spacer()
                Text(String(detailModel.detail[0].low24h))
                    .bold()
            }
            .padding(.bottom,10)
            HStack {
                Text("Release date")
                    .bold()
                Spacer()
                Text(String(detailModel.detail[0].releaseDate))
                    .bold()
            }
        
                 
            Spacer()
        }.padding()
        
        .toolbar(content: {
            
            ToolbarItem(placement:.navigationBarTrailing)
            {
                
                Image(systemName: "star.fill")
                    .resizable()
                    .frame(width: 20, height: 20)
                
                    .foregroundColor(.black)
                
                
                
            }
        })
        
    }
}

#Preview {
    
    DetailView(detailModel: DetailViewModel())
}
