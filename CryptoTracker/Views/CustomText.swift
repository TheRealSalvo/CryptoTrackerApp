//
//  CustomText.swift
//  CryptoTracker
//
//  Created by Salvatore Attanasio on 18/12/23.
//

import SwiftUI

struct CustomText: View {
    enum TextType{
        case marketCap
        case volume
        case priceChange
        case currency
        case none
    }
    
    @State private var textType : TextType
    
    @State private var text  = ""
    @State private var value = 0.0
    
    private var labelText : String{
        switch (self.textType) {
            case .marketCap:
                return formatMarketCap(value)
            case .volume:
                return formatVolume(value)
            case .priceChange:
                return formatPriceChange(value)
            default:
                return text
        }
    }
    
    init(_ text: String){
        self.textType = .none
        self.text = text
    }
    
    init(_ value: Double, textType : TextType = .none){
        self.textType = textType
        self.value = value
    }
    
    var body: some View {
        Text(self.labelText)
    }
    
    private func formatMarketCap(_ marketCap: Double) -> String {
        if marketCap >= 1_000_000_000 {
            return String(format: "MarketCap: $%.01fB", marketCap / 1_000_000_000)
        } else if marketCap >= 1_000_000 {
            return String(format: "MarketCap: $%.01fM", marketCap / 1_000_000)
        } else {
            return "MarketCap: N/A"
        }
    }
    
    private func formatVolume(_ volume: Double) -> String {
        if volume >= 1_000_000_000 {
            return String(format: "Volume 24h: $%.01fB", volume / 1_000_000_000)
        } else if volume >= 1_000_000 {
            return String(format: "Volume 24h: $%.01fM", volume / 1_000_000)
        } else {
            return "Volume 24h: N/A"
        }
    }
    
    private func formatPriceChange(_ priceChange: Double) -> String {
        return String(format: "%.2f%%", priceChange)
    }
}

#Preview {
    CustomText(11111.0, textType: .marketCap)
}
