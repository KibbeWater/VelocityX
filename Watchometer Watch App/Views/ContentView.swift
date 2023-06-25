//
//  ContentView.swift
//  Watchometer Watch App
//
//  Created by user242911 on 6/25/23.
//

import SwiftUI
import SpeedKit

struct ContentView: View {
    @ObservedObject private var speedManager = LocationManager.shared
    
    @State private var speed: Double = 0
    
    @AppStorage("speedConversionCounter")
    private var speedConversionCounter: SpeedConversions = .kmph
    
    var body: some View {
        NavigationView {
            VStack {
                GeometryReader { geo in
                    VStack {
                        Text(speedConversionCounter.rawValue)
                            .font(.title)
                        Text(String(format: "%02d", getFlooredSpeed()))
                            .font(.system(size: fontSize(for: geo.size)))
                            .animation(.easeInOut, value: getFlooredSpeed())
                        
                    }
                    .frame(width: geo.size.width, height: geo.size.height)
                }
            }
            .onChange(of: speedManager.speed) { newSpeed in
                withAnimation {
                    speed = newSpeed
                }
            }
            .overlay(alignment: .bottomTrailing) {
                NavigationLink(destination: Settings()) {
                    Image(systemName: "gear")
                        .padding(.horizontal)
                }
                .buttonStyle(.plain)
            }
        }
    }
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.45
    }
    
    func getFlooredSpeed() -> Int {
        return Int(floor(Utils.shared.ConvertSpeed(from: .mps, to: speedConversionCounter, value: speed)))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
