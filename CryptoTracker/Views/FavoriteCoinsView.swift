
//  ContentView.swift
//  Crypto App
//
//  Created by Salvatore Capasso on 11/12/23.
//

import SwiftUI

struct FavoriteCoinsView: View {
    @State private var searchText = ""
   var viewModel : CardViewModel
    
    var body: some View {
       
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                
                LazyVGrid(columns: [GridItem(.fixed(360))], spacing: 7) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card)
                            .contextMenu(menuItems: {
                                Text("Menu Item 1")
                                Text("Menu Item 2")
                                Text("Menu Item 3")
                            })
                        
                        
                    }
                  
                }
            }
            .scrollClipDisabled()
            .padding()
            .navigationTitle("Favourite Coins")
           
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName:"plus.circle")
                           
                    }
                }
            }
        }  .searchable(text: $searchText)
    }
}
    #Preview {
        FavoriteCoinsView(viewModel: CardViewModel())
    }

