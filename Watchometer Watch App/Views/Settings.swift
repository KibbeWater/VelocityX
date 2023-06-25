//
//  Settings.swift
//  Watchometer Watch App
//
//  Created by user242911 on 6/25/23.
//

import SwiftUI
import SpeedKit

struct Settings: View {
    @AppStorage("speedConversionCounter")
    private var speedConversionCounter: SpeedConversions = .kmph
    
    @AppStorage("speedConversionGraph")
    private var speedConversionGraph: SpeedConversions = .kmph
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Speed Counter")) {
                    Picker("Display Unit", selection: $speedConversionCounter) {
                        ForEach(SpeedConversions.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.automatic)
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
