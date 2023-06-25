//
//  SpeedGauge.swift
//  Speedometer
//
//  Created by user242911 on 6/25/23.
//

import SwiftUI
import SpeedKit

private struct GaugeShape: Shape {
    let startAngle: Angle
    let endAngle: Angle
    
    func path(in rect: CGRect) -> Path {
        let radius = rect.width / 2
        
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY),
                    radius: radius,
                    startAngle: startAngle,
                    endAngle: endAngle,
                    clockwise: false)
        
        return path.strokedPath(StrokeStyle(lineWidth: 20, lineCap: .round))
    }
}

private struct MinmaxShape: Shape {
    let angle: Angle
    
    func path(in rect: CGRect) -> Path {
        let radius = rect.width / 2
        
        var path = Path()
        
        let circleRadius: CGFloat = 20
        let minCircleCenter = CGPoint(x: rect.midX + radius * cos(CGFloat(angle.radians)),
                                              y: rect.midY + radius * sin(CGFloat(angle.radians)))
        let minCirclePath = Path(ellipseIn: CGRect(x: minCircleCenter.x - circleRadius,
                                                           y: minCircleCenter.y - circleRadius,
                                                           width: circleRadius * 2,
                                                           height: circleRadius * 2))
        
        path.addPath(minCirclePath)
        
        return path
    }
}

private struct Gauge: View {
    let minVal: Int
    let maxVal: Int
    var currentValue: Int
    
    private let startAngle = Angle(degrees: 150)
    private let endAngle = Angle(degrees: 30)
    
    var body: some View {
        GeometryReader { geometry in
            GaugeShape(startAngle: startAngle, endAngle: endAngle)
            
            MinmaxShape(angle: startAngle)
                .overlay {
                    let point = getRadiusPosition(in: geometry.frame(in: .local), angle: startAngle)
                    Text(String(minVal))
                        .position(x: point.x, y: point.y)
                        .foregroundColor(Color(uiColor: .systemBackground))
                }
            MinmaxShape(angle: endAngle)
                .overlay {
                    let point = getRadiusPosition(in: geometry.frame(in: .local), angle: endAngle)
                    Text(String(maxVal))
                        .position(x: point.x, y: point.y)
                        .foregroundColor(Color(uiColor: .systemBackground))
                }
            
            MinmaxShape(angle: valueAngle)
                .overlay {
                    let point = getRadiusPosition(in: geometry.frame(in: .local), angle: valueAngle)
                    Text(String(currentValue))
                        .position(x: point.x, y: point.y)
                        .foregroundColor(Color(uiColor: .systemBackground))
                }
        }
    }
    
    var valueRange: Double {
            return Double(maxVal - minVal)
        }

        var valueAngle: Angle {
            let valueRatio = Double(currentValue - minVal) / valueRange
            let angleRange = startAngle - endAngle
            return Angle(radians: angleRange.radians * valueRatio + endAngle.radians)
        }

        func getRadiusPosition(in rect: CGRect, angle: Angle) -> CGPoint {
            let radius = rect.width / 2
            
            return CGPoint(x: rect.midX + radius * cos(CGFloat(angle.radians)),
                           y: rect.midY + radius * sin(CGFloat(angle.radians)))
        }
}

struct SpeedGauge: View {
    @Binding var speed: Double
    var speedConversion: SpeedConversions = .kmph
    
    var body: some View {
        Gauge(minVal: 0, maxVal: 100, currentValue: getFlooredSpeed())
            .padding()
            .overlay {
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
    }
    
    func getFlooredSpeed() -> Int {
        return Int(Utils.shared.RoundSpeed(speed: Utils.shared.ConvertSpeed(from: .mps, to: speedConversion, value: speed)))
    }
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.3
    }
}

struct SpeedGauge_Previews: PreviewProvider {
    static var previews: some View {
        SpeedGauge(speed: .constant(15))
    }
}
