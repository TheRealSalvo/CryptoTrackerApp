//
//  CardView.swift
//  CryptoTracker
//
//  Created by SHOHJAHON on 13/12/23.
//

import SwiftUI

struct CardView: View {
    let card: CardModel
    
    var body: some View {
        VStack(alignment: .leading){
            HStack {
                card.ImageSymbol
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50)
                    .frame(height: 50)
                Text(card.Name)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .bold()
                    .foregroundStyle(Color.white)
                Image(systemName: "triangle.fill")
                    .foregroundStyle(Color.green)
                Spacer()
                VStack(alignment: .trailing) {
                    Text("+56")
                        .foregroundStyle(Color.green)
                    Text("+56")
                        .foregroundStyle(Color.green)
                }
                Spacer()
                
            }

            VStack(alignment: .leading) {
                Text("Open")
                Text("High")
                Text("Low")
            }   .foregroundStyle(Color.gray)
            
            Spacer()
            
            VStack(alignment: .leading) {
                Text("\(card.Value)")
                    .foregroundStyle(Color.white)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            }
        }
        .frame(maxHeight: 180)
        .padding()
        .background(.banana)
        .cornerRadius(10)
        .padding()
    }
}

#Preview {
    let card =  CardModel(Name: "Bitcoin", Value: 23.45, ImageSymbol: Image("bitcoin"))
    return CardView(card: card)
}
