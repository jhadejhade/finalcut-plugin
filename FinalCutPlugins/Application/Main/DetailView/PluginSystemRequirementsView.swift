//
//  PluginSystemRequirementsView.swift
//  FinalCutPlugins
//
//  Created by Jade Lapuz on 7/1/25.
//

import SwiftUI

struct PluginSystemRequirementsView: View {
    private let systemRequirements = [
        "macOS 12.0 or later",
        "Final Cut Pro 10.6+",
        "8GB RAM minimum",
        "Metal-compatible GPU",
        "2GB free disk space"
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("System Requirements")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 8) {
                ForEach(systemRequirements, id: \.self) { requirement in
                    HStack(spacing: 8) {
                        Image(systemName: "desktopcomputer")
                            .foregroundColor(.blue)
                            .font(.caption)
                        
                        Text(requirement)
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Spacer()
                    }
                    .padding(.vertical, 4)
                }
            }
            .padding()
            .background(Color(NSColor.controlBackgroundColor))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .padding(.horizontal, 20)
    }
}