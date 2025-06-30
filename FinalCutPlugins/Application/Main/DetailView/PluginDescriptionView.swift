//
//  PluginDescriptionView.swift
//  FinalCutPlugins
//
//  Created by Jade Lapuz on 7/1/25.
//

import SwiftUI

struct PluginDescriptionView: View {
    let plugin: PluginUIModel
    @Binding var showFullDescription: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("About")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                Spacer()
            }
            
            Text(showFullDescription ? plugin.description + "\n\nThis comprehensive plugin transforms your Final Cut Pro workflow with advanced features and intuitive controls. Perfect for both beginners and professionals looking to enhance their video editing capabilities." : plugin.description)
                .font(.body)
                .foregroundColor(.secondary)
                .lineLimit(showFullDescription ? nil : 3)
                .animation(.easeInOut(duration: 0.3), value: showFullDescription)
            
            Button(action: {
                withAnimation(.easeInOut(duration: 0.3)) {
                    showFullDescription.toggle()
                }
            }) {
                Text(showFullDescription ? "Show Less" : "Show More")
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.blue)
            }
        }
        .padding(.horizontal, 20)
    }
}