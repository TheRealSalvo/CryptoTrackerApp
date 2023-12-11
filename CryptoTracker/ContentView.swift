//
//  ContentView.swift
//  CryptoTracker
//
//  Created by Salvatore Attanasio on 11/12/23.
//

import SwiftUI

var prices: [Double] = [1.0, 2.5, 3.7, 4.2, 5.8, 6.4, 7.1, 8.9, 9.3, 10.6, 11.2, -1.0, 13.4, 14.8, 15.2, 16.6, 17.3, 18.9, 19.5, 20.0]

struct Sparkline: Shape{
    var points : [Double]
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let sPoints = points.sorted { $0 < $1}
        let maxYCoord = sPoints.map {$0}.max() ?? 1
        let maxXCoord = 7.0
        let xScale: CGFloat = rect.maxX / CGFloat(maxXCoord)
        let yScale: CGFloat = rect.maxY / CGFloat(maxYCoord)
        var i = 0
        let x_increment = maxXCoord / Double(points.count)
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY - (CGFloat(points[0]) * yScale)) )
        for item in points {
            path.addLine(to: CGPoint(x: rect.minX + (Double(i) * x_increment * xScale), y: rect.maxY - (item * yScale) ))
            i = i+1
        }
        path.stroke(.black, lineWidth: 10.0)
        return path
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        Sparkline(points: prices).path(in: CGRect(x: 0, y: 100, width: 250.0, height: 100.0))
            .stroke(.black, lineWidth: 10.0)
    }
}

#Preview {
    ContentView()
}
