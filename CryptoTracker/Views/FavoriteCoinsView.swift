//
//  FavoriteCoinsView.swift
//  CryptoTracker
//
//  Created by SHOHJAHON on 13/12/23.
//

import SwiftUI

struct MainChartsView: View {
    @State private var searchText = ""
    var body: some View {
       
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                
                LazyVGrid(columns: [GridItem(.fixed(360))], spacing: 7) {
                    ForEach(CardViewModal().Cards) { card in
                        CardView(card: card)
                            .contextMenu(menuItems: {
                                Text("Menu Item 1")
                                Text("Menu Item 2")
                                Text("Menu Item 3")
                            })
                        
                        
                    }
                    Text("Searching for \(searchText)")
                                   .navigationTitle("Searchable Example")
                }
            }
            .scrollClipDisabled()
            .padding()
            .navigationTitle(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=Title@*/Text("Title")/*@END_MENU_TOKEN@*/)
            .toolbar {
                //                ToolbarItem(placement: .navigationBarTrailing)
            }
            
        }
    }
}
    #Preview {
        MainChartsView()
    }
