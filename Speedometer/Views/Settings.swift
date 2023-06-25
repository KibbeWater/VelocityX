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
    private var speedConversionGraph: SpeedConversions = .kmph
    
    @AppStorage("speedConversionGauge")
    private var speedConversionGauge: SpeedConversions = .kmph
    
    @AppStorage("primaryComponent")
    private var primaryComponent: ComponentType = .gauge
    
    @AppStorage("secondaryComponent")
    private var secondaryComponent: ComponentType = .graph
    
    var body: some View {
        NavigationView {
            Form {
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
