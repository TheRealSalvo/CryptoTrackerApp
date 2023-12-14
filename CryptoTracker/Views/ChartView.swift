//
//  ChartView.swift
//  CryptoTracker
//
//  Created by Salvatore Attanasio on 11/12/23.
//

import SwiftUI
import Charts

struct ChartView: View {
    var data : [(x:Double, y:Double)]
    private var scaleFactor : Double
    
    private var min : Double
    private var max : Double
    
    init(of data: [Double], scaleFactor: Double = 1.2) {
        self.data = []
        
        if(scaleFactor > 0){
            self.scaleFactor = scaleFactor
        }else{
            print("Invalid value for scale factor. Defaulting to 1.2")
            self.scaleFactor = 1.2
        }
        
        var index = 0.0
        for element in data{
            self.data.append((x: index, y: element))
            index += 1.0
        }
        self.min = data.min() ?? 0.0
        self.max = data.max() ?? 0.0
    }
    
    var body: some View {
        Chart(data, id: \.x){ element in
            LineMark(
                x: .value("Time", element.x),
                y: .value("Value", element.y)
            )
        }
        .chartYAxis(.hidden)
        .chartXAxis(.hidden)
        .chartYScale(domain: [self.min / self.scaleFactor, self.max * self.scaleFactor])
    }
}

#Preview {
    ChartView(of: [48000.0, 48500.0, 49000.0, 49500.0, 50000.0, 49500.0, 49000.0, 48500.0, 48000.0, 47500.0, 47000.0, 46500.0, 46000.0, 45500.0, 45000.0, 44500.0, 44000.0, 43500.0, 43000.0, 42500.0, 42000.0, 41500.0, 41000.0, 40500.0, 40000.0, 39500.0, 39000.0, 38500.0, 38000.0, 37500.0, 37000.0, 36500.0, 36000.0, 35500.0, 35000.0, 34500.0, 34000.0, 33500.0, 33000.0, 32500.0, 32000.0, 31500.0, 31000.0, 30500.0, 30000.0, 29500.0, 29000.0, 28500.0, 28000.0]
    )
    .frame(width: 300, height: 100)
}
