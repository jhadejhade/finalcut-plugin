//
//  PluginScreenshotsView.swift
//  FinalCutPlugins
//
//  Created by Jade Lapuz on 7/1/25.
//

import SwiftUI

struct PluginScreenshotsView: View {
    let plugin: PluginUIModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Screenshots")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                Spacer()
            }
            .padding(.horizontal, 20)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(Array(plugin.screenshots.enumerated()), id: \.offset) { index, screenshotURL in
                        AsyncImage(url: screenshotURL) { image in
                            image
                                .resizable()
                                .aspectRatio(16/9, contentMode: .fill)
                        } placeholder: {
                            Rectangle()
                                .fill(Color(NSColor.controlBackgroundColor))
                                .overlay(
                                    ProgressView()
                                        .scaleEffect(0.8)
                                )
                        }
                        .frame(width: 300, height: 169)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                    }
                }
                .padding(.horizontal, 20)
            }
        }
        .padding(.bottom, 40)
    }
}
