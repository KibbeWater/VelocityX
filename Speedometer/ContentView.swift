//
//  ContentView.swift
//  Speedometer
//
//  Created by user242911 on 6/23/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var speedManager = LocationManager.shared
    
    var body: some View {
        HStack {
            Text(String(getSpeedDigit(speed: speedManager.speed, digitIdx: 0)))
                .font(.system(size: 128))
                .transition(.slide.combined(with: .opacity))
            Text(String(getSpeedDigit(speed: speedManager.speed, digitIdx: 1)))
                .font(.system(size: 128))
                .transition(.slide.combined(with: .opacity))
            if digitCount(speed: speedManager.speed) > 2 {
                ForEach(2..<digitCount(speed: speedManager.speed), id: \.self) { i in
                    Text(String(getSpeedDigit(speed: speedManager.speed, digitIdx: i)))
                        .font(.system(size: 128))
                        .transition(.slide.combined(with: .opacity))
                    
                }
            }
        }
        .padding()
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
