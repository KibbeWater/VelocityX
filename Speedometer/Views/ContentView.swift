//
//  ContentView.swift
//  Speedometer
//
//  Created by user242911 on 6/23/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var speedManager = LocationManager.shared
    
    @State private var speed: Double = 0
    
    private var graphResolution = 5 // Will capture {graphResolution} snaphots over {graphSeconds} seconds
    private var graphSeconds = 4
    @State private var graphHistory: [Double] = [0]
    @State private var graphCursor: Int = 0
    
    @State private var viewDidLoad = false
    @State var timer: Timer?
    
    @AppStorage("speedConversionCounter")
    private var speedConversionCounter: SpeedConversions = .kmph
    
    @AppStorage("speedConversionGraph")
    private var speedConversionGraph: SpeedConversions = .kmph
    
    var body: some View {
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
            Spacer()
            SpeedGraph(history: $graphHistory, cursorPosition: $graphCursor, speedConversion: speedConversionGraph)
                .padding()
        }
        .onChange(of: speedManager.speed) { newSpeed in
            withAnimation {
                speed = newSpeed
            }
        }
        .onAppear {
            if !viewDidLoad {
                //var speedPoints = [SpeedPoint]()
                //for idx in 0..<totalGraphEntries() {
                //    let point = SpeedPoint(value: 0.0, idx: idx)
                //    speedPoints.append(point)
                //}
                //graphHistory = Array(repeating: 0, count: totalGraphEntries())
                
                self.timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(graphDelay()), repeats: true, block: { _ in
                    captureSpeedSnapshot()
                })
                viewDidLoad = true
            }
        }
        .overlay(alignment: .topTrailing) {
            NavigationLink {
                Settings()
            } label: {
                Image(systemName: "gear")
                    .imageScale(.large)
                    .foregroundColor(.black)
            }
            .padding(.trailing)
        }
    }
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.45
    }
    
    func graphDelay() -> Double {
        return 1.0 / Double(graphResolution)
    }
    
    func getFlooredSpeed() -> Int {
        return Int(floor(Utils.shared.ConvertSpeed(from: .mps, to: speedConversionCounter, value: speed)))
    }
    
    func totalGraphEntries() -> Int {
        return graphResolution * graphSeconds
    }
    
    func incrementCursor() {
        graphCursor = graphCursor + 1 >= totalGraphEntries() ? 0 : graphCursor + 1
    }
    
    func captureSpeedSnapshot() {
        //graphHistory[graphCursor] = speed//SpeedPoint(value: speed, idx: graphCursor)
        graphHistory.append(speed)
        incrementCursor()
        
        if graphHistory.count > totalGraphEntries() {
            let removalCount = graphHistory.count - totalGraphEntries()
            graphHistory.removeFirst(removalCount)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}