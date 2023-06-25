//
//  SpeedCounter.swift
//  Speedometer
//
//  Created by user242911 on 6/25/23.
//

import SwiftUI
import SpeedKit

struct SpeedCounter: View {
    @Binding var speed: Double
    var speedConversion: SpeedConversions = .kmph
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Text(speedConversion.rawValue)
                    .font(.title)
                Text(String(format: "%02d", getFlooredSpeed()))
                    .font(.system(size: fontSize(for: geo.size)))
                    .animation(.easeInOut, value: getFlooredSpeed())
                
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
    }
    
    func getFlooredSpeed() -> Int {
        return Int(floor(Utils.shared.ConvertSpeed(from: .mps, to: speedConversion, value: speed)))
    }
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.48
    }
}

struct SpeedCounter_Previews: PreviewProvider {
    static var previews: some View {
        SpeedCounter(speed: .constant(15))
    }
}
