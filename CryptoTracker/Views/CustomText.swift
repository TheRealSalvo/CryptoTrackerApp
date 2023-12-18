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
        case priceChangePercentage
        case currency
        case none
    }
    
    @State private var textType : TextType
    
    @State private var text  = ""
    @State private var value : Double
    
    private var labelText : String{
        switch (self.textType) {
            case .currency:
                return formatCurrency(self.value)
            case .marketCap:
                return formatMarketCap(self.value)
            case .volume:
                return formatVolume(self.value)
            case .priceChangePercentage:
                return formatPriceChangePercentage(self.value)
            default:
                return text
        }
    }
    
    init(_ text: String){
        self.textType = .none
        self.text = text
        self.value = 0.0
    }
    
    init(_ value: Double, textType : TextType = .none){
        self.textType = textType
        self.value = value
    }
    
    var body: some View {
        Text(self.labelText)
    }
    
    private func formatCurrency(_ value: Double) -> String {
        if(value > 1000){
            return String(format: "$%.02f$")
        }else if (value > 0){
            return String(format: "$%.04f$")
        }else{
            return String(format: "$%.06f$")
        }
    }
    
    private func formatMarketCap(_ marketCap: Double) -> String {
        if marketCap >= 1_000_000_000 {
            return String(format: "MarketCap: $%.01fB", marketCap / 1_000_000_000)
        } else if marketCap >= 1_000_000 {
            return String(format: "MarketCap: $%.01fM", marketCap / 1_000_000)
        } else {
            return String(marketCap)
        }
    }
    
    private func formatVolume(_ volume: Double) -> String {
        if volume >= 1_000_000_000 {
            return String(format: "Volume: $%.01fB", volume / 1_000_000_000)
        } else if volume >= 1_000_000 {
            return String(format: "Volume: $%.01fM", volume / 1_000_000)
        } else {
            return String(volume)
        }
    }
    
    private func formatPriceChangePercentage(_ priceChange: Double) -> String {
        if(priceChange < 0){
            return String(format: "%.3f%%", priceChange)
        }else{
            return String(format: "+%.3f%%", priceChange)
        }
        
    }
}

#Preview {
    CustomText(0.456, textType: .priceChangePercentage)
}
