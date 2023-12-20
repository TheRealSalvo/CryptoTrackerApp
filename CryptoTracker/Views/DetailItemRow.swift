//
//  DetailGridItemRow.swift
//  CryptoTracker
//
//  Created by SHOHJAHON on 18/12/23.
//

import SwiftUI

struct DetailItemRow: View {
    
    private var title: String
    private var value: String
    
    init(_ title: String, value: Int) {
        self.title = title
        self.value = String(value)
    }
    
    init(_ title: String, value: Double) {
        self.title = title
        self.value = String(value)
    }
    
    init(_ title: String, value: String) {
        self.title = title
        self.value = value
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Divider()
            HStack {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .textCase(.uppercase)
                    .kerning(1.0)
                    .foregroundStyle(.foreground.opacity(0.5))
                Spacer()
            }
            HStack {
                Text(value)
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
            }
        }
    }
}
