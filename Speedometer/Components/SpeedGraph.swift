//
//  SpeedGraph.swift
//  Speedometer
//
//  Created by user242911 on 6/24/23.
//

import SwiftUI
import Charts
import SpeedKit

struct SpeedPoint: Identifiable {
    let id: UUID
    let speed: Double
    let idx: Int

    init(value: Double, idx: Int) {
        self.id = UUID()
        self.speed = value
        self.idx = idx
    }
}

struct SpeedGraph: View {
    @Binding var history: [Double]
    @Binding var cursorPosition: Int
    var speedConversion: SpeedConversions = .kmph
    
    var body: some View {
        Chart {
            ForEach(Array(history.enumerated()), id: \.offset) { index, value in
                LineMark(
                    x: .value("Time", index),
                    y: .value(speedConversion.rawValue, Utils.shared.ConvertSpeed(from: .mps, to: speedConversion, value: value))
                )
                .interpolationMethod(.catmullRom)
                .lineStyle(StrokeStyle(lineWidth: 4, lineCap: .round))
            }
            //PointMark(
            //    x: .value("Time", cursorPosition == 0 ? 0 : cursorPosition - 1),
            //    y: .value("Speed", cursorPosition == 0 ? history[history.count-1] : history[cursorPosition-1])
            //)
        }
        .chartYAxis {
            AxisMarks {
                let value = $0.as(Double.self)!
                AxisValueLabel(String(format: "%.0f \(speedConversion.rawValue)", value))
            }
        }
    }
    
    func speedConversionToUnit() -> Unit {
        switch speedConversion {
        case .kmph:
            return UnitSpeed.kilometersPerHour
        case .mph:
            return UnitSpeed.milesPerHour
        case .mps:
            return UnitSpeed.metersPerSecond
        case .kn:
            return UnitSpeed.knots
        }
    }
}

struct SpeedGraph_Previews: PreviewProvider {
    static var previews: some View {
        SpeedGraph(history: .constant([0]), cursorPosition: .constant(0))
    }
}
