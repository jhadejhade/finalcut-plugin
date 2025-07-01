//
//  PluginFeaturesView.swift
//  FinalCutPlugins
//
//  Created by Jade Lapuz on 7/1/25.
//

import SwiftUI

struct PluginFeaturesView: View {
    let plugin: PluginUIModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Features")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                Spacer()
            }
            
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 12) {
                ForEach(plugin.features, id: \.self) { feature in
                    FeatureRow(feature: feature)
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 40)
    }
}

struct FeatureRow: View {
    let feature: String
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "checkmark.circle.fill")
                .foregroundColor(.green)
                .font(.caption)
            
            Text(feature)
                .font(.subheadline)
                .foregroundColor(.primary)
                .multilineTextAlignment(.leading)
            
            Spacer()
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(Color(NSColor.controlBackgroundColor))
        .cornerRadius(8)
    }
}
