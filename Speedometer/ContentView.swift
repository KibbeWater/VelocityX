//
//  ContentView.swift
//  Speedometer
//
//  Created by user242911 on 6/23/23.
//

import SwiftUI

struct ContentView: View {
    @State private var speed = 611
    
    var body: some View {
        HStack {
            ForEach(0..<digitCount(), id: \.self) { i in
                Text(String(getSpeedDigit(digitIdx: i)))
                    .font(.system(size: 128))
            }
        }
        .padding()
    }
    
    func getSpeedDigit(digitIdx: Int32) -> Int32 {
        return Int32(Double(speed) / pow(Double(10), Double((digitCount() - 1) - digitIdx))) % 10
    }
    
    func digitCount() -> Int32 {
        return Int32(log10(Double(speed))) + 1
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
