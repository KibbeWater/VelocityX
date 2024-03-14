//
//  Settings.swift
//  Speedometer
//
//  Created by user242911 on 6/24/23.
//

import SwiftUI
import SpeedKit

struct Settings: View {
    @AppStorage("speedConversionCounter")
    private var speedConversionCounter: SpeedConversions = .kmph
    
    @AppStorage("speedConversionGraph")
    private var speedConversionGraph: SpeedConversions = .mps
    
    @AppStorage("speedConversionGauge")
    private var speedConversionGauge: SpeedConversions = .kmph
    
    @AppStorage("primaryComponent")
    private var primaryComponent: ComponentType = .counter
    
    @AppStorage("secondaryComponent")
    private var secondaryComponent: ComponentType = .graph
    
    @AppStorage("speedRounding")
    private var speedRounding: RoundingType = .floor
    
    @AppStorage("speedDecimalsCounter")
    private var speedDecimalsCounter: Int = 1
    
    @AppStorage("counterPadding")
    private var counterPadding: Bool = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Speed Display Options")) {
                    Picker("Rounding Type", selection: $speedRounding) {
                        ForEach(RoundingType.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.menu)
                }
                
                Section(header: Text("Components")) {
                    Picker("Primary Component", selection: $primaryComponent) {
                        ForEach(ComponentType.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.menu)
                    
                    Picker("Secondary Component", selection: $secondaryComponent) {
                        ForEach(ComponentType.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.menu)
                }
                
                Section(header: Text("Speed Counter")) {
                    Picker("Display Unit", selection: $speedConversionCounter) {
                        ForEach(SpeedConversions.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.menu)
                    
                    Stepper(value: $speedDecimalsCounter, in: 0...5, step: 1) {
                        Text("Decimals: x\(speedDecimalsCounter <= 0 ? "" : ".\(String(repeating: "0", count: speedDecimalsCounter-1))1")")
                    }
                    
                    Toggle(isOn: $counterPadding) {
                        Text("Counter always 2 digits")
                    }
                }
                
                Section(header: Text("Speed Graph")) {
                    Picker("Display Unit", selection: $speedConversionGraph) {
                        ForEach(SpeedConversions.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.menu)
                }
                
                Section(header: Text("Speed Gauge")) {
                    Picker("Display Unit", selection: $speedConversionGraph) {
                        ForEach(SpeedConversions.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.menu)
                }
            }
            .formStyle(.grouped)
        }
        .navigationBarTitle(Text("Settings"))
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
