//
//  ContentView.swift
//  Speedometer
//
//  Created by user242911 on 6/23/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var speedManager = LocationManager.shared
    
    @State private var speed: Int = 0
    @State private var previousSpeed: Int = 0
    
    var body: some View {
        GeometryReader { geo in
            Text(String(format: "%02d", speed))
                .font(.system(size: 128))
                .foregroundColor(.black)
                .position(x: geo.frame(in: .local).midX, y: geo.frame(in: .local).midY)
        }
        .onChange(of: speedManager.speed) { newSpeed in
            withAnimation {
                previousSpeed = speed
                speed = newSpeed
            }
        }
    }
    
    func getSpeedDigit(speed: Int32, digitIdx: Int32) -> Int32 {
        return Int32(Double(speed) / pow(Double(10), Double((digitCount(speed: speed) - 1) - digitIdx))) % 10
    }
    
    func digitCount(speed: Int32) -> Int32 {
        if speed <= 0 {
            return 1
        } else {
            return Int32(log10(Double(speed))) + 1
        }
    }
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.9
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
