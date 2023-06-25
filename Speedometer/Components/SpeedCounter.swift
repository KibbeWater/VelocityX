//
//  SpeedCounter.swift
//  Speedometer
//
//  Created by user242911 on 6/25/23.
//

import SwiftUI
import SpeedKit

struct SpeedCounter: View {
    @AppStorage("speedDecimalsCounter")
    private var speedDecimalsCounter: Int = 1
    
    @Binding var speed: Double
    var speedConversion: SpeedConversions = .kmph
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Text(speedConversion.rawValue)
                    .font(.title)
                Text(hasDecimals(getFlooredSpeed()) ? String(getFlooredSpeed()) : String(format: "%02.0f", getFlooredSpeed()))
                    .font(.system(size: fontSize(for: geo.size)))
                    .animation(.easeInOut, value: getFlooredSpeed())
                
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
    }
    
    func getFlooredSpeed() -> Double {
        return Utils.shared.RoundSpeed(speed: Utils.shared.ConvertSpeed(from: .mps, to: speedConversion, value: speed), decimals: speedDecimalsCounter)
    }
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.28
    }
    
    func hasDecimals(_ value: Double) -> Bool {
        let roundedValue = value.rounded()
        return value != roundedValue
    }
}

struct SpeedCounter_Previews: PreviewProvider {
    static var previews: some View {
        SpeedCounter(speed: .constant(15))
    }
}
