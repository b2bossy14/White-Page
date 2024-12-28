//
//  SettingsView.swift
//  Yellow Page
//
//  Created by Bryson Toubassi on 12/26/24.
//

import SwiftUI

struct SettingsView: View {
    @State private var showFatherContactInfo = true
    @State private var showMotherContactInfo = true
    @State private var showChildrenInfo = false

    var body: some View {
        Form {
            Section(header: Text("Settings")) {
                Toggle("Show Father's Contact Info", isOn: $showFatherContactInfo)
                Toggle("Show Mother's Contact Info", isOn: $showMotherContactInfo)
                Toggle("Show Children Info", isOn: $showChildrenInfo)
            }
            .tint(.blue)
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    SettingsView()
}
