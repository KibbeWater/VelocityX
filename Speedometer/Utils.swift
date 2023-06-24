//
//  Utils.swift
//  Speedometer
//
//  Created by user242911 on 6/25/23.
//

import Foundation

public enum SpeedConversions: String, CaseIterable {
    case kmph = "km/h"
    case mph = "mph"
    case mps = "m/s"
    case kn = "knots"
}

public class Utils {
    public static let shared = Utils()
    
    public func ConvertSpeed(from: SpeedConversions, to: SpeedConversions, value: Double) -> Double {
        let baseSpeed = convertToBaseUnit(speed: value, unit: from)
        let convertedSpeed = convertFromBaseUnit(speed: baseSpeed, unit: to)
        
        return convertedSpeed
    }
    
    private func convertToBaseUnit(speed: Double, unit: SpeedConversions) -> Double {
        switch unit {
        case .kmph:
            return speed * 1000 / 3600
        case .mph:
            return speed * 1609.34 / 3600
        case .mps:
            return speed
        case .kn:
            return speed * 1852 / 3600
        }
    }
    
    private func convertFromBaseUnit(speed: Double, unit: SpeedConversions) -> Double {
        switch unit {
        case .kmph:
            return speed * 3600 / 1000
        case .mph:
            return speed * 3600 / 1609.34
        case .mps:
            return speed
        case .kn:
            return speed * 3600 / 1852
        }
    }
}
