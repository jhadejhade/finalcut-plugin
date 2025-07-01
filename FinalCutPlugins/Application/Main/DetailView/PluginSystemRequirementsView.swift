//
//  PluginSystemRequirementsView.swift
//  FinalCutPlugins
//
//  Created by Jade Lapuz on 7/1/25.
//

import SwiftUI

struct PluginSystemRequirementsView: View {
    let plugin: PluginUIModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("System Requirements")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                Spacer()
            }
            
            VStack(spacing: 0) {
                SystemRequirementRow(title: "macOS", value: plugin.systemRequirements.macOS)
                SystemRequirementRow(title: "Final Cut Pro", value: plugin.systemRequirements.finalCutPro)
                SystemRequirementRow(title: "Memory", value: plugin.systemRequirements.memory)
                SystemRequirementRow(title: "Graphics", value: plugin.systemRequirements.graphics)
                SystemRequirementRow(title: "Processor", value: plugin.systemRequirements.processor)
                SystemRequirementRow(title: "Storage", value: plugin.systemRequirements.storage)
            }
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 40)
    }
}

struct SystemRequirementRow: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                
                Spacer()
            }
            
            Text(value)
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.leading)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(Color(NSColor.controlBackgroundColor))
    }
}
