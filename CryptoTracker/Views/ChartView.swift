//
//  ChartView.swift
//  CryptoTracker
//
//  Created by Salvatore Attanasio on 11/12/23.
//

import SwiftUI
import Charts

struct ChartView: View {
    let data : [Double]
    
    init(of data: [Double]) {
        self.data = data
    }
    
    var body: some View {
        Chart(data, id: \.self) {
            LineMark(
                x: .value("Time", data.firstIndex(of: $0) ?? 0),
                y: .value("Value", $0)
            )
        }
    }
}

#Preview {
    ChartView(of: [1,2,3])
        .chartXAxis(.hidden)
}
