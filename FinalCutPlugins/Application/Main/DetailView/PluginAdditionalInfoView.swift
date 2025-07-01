//
//  PluginAdditionalInfoView.swift
//  FinalCutPlugins
//
//  Created by Jade Lapuz on 7/1/25.
//

import SwiftUI

struct PluginAdditionalInfoView: View {
    let plugin: PluginUIModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Additional Information")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                Spacer()
            }
            
            VStack(spacing: 0) {
                InfoRow(title: "Category", value: plugin.category)
                InfoRow(title: "Size", value: plugin.size)
                InfoRow(title: "Updated", value: plugin.updated)
                InfoRow(title: "Language", value: plugin.language)
                InfoRow(title: "Compatibility", value: plugin.compatibility)
                InfoRow(title: "Price", value: plugin.price)
            }
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 40)
    }
}

struct InfoRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Spacer()
            
            Text(value)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(.primary)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
        .background(Color(NSColor.controlBackgroundColor))
    }
}
