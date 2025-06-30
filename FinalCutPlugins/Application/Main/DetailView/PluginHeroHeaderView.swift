//
//  PluginHeroHeaderView.swift
//  FinalCutPlugins
//
//  Created by Jade Lapuz on 7/1/25.
//

import SwiftUI

struct PluginHeroHeaderView: View {
    let plugin: PluginUIModel
    let scrollOffset: CGFloat
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // Background Image with Parallax
            AsyncImage(url: plugin.imageUrl) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 300 + max(0, -scrollOffset))
                    .offset(y: scrollOffset * 0.5)
                    .clipped()
            } placeholder: {
                Rectangle()
                    .fill(
                        LinearGradient(
                            colors: [Color.blue.opacity(0.6), Color.purple.opacity(0.8)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(height: 300 + max(0, -scrollOffset))
                    .offset(y: scrollOffset * 0.5)
            }
            
            // Gradient Overlay
            LinearGradient(
                colors: [Color.clear, Color.black.opacity(0.8)],
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(height: 300 + max(0, -scrollOffset))
            .offset(y: scrollOffset * 0.5)
            
            // Plugin Info Overlay
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            // State Badge
                            PluginStateBadge(state: plugin.state)
                            
                            Spacer()
                            
                            PluginVersionBadge(version: plugin.version)
                        }
                        
                        Text(plugin.name)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        HStack(spacing: 6) {
                            Image(systemName: "person.fill")
                                .foregroundColor(.white.opacity(0.8))
                            Text(plugin.developer)
                                .font(.title3)
                                .fontWeight(.medium)
                                .foregroundColor(.white.opacity(0.9))
                        }
                    }
                    
                    Spacer()
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 30)
        }
        .frame(height: 300)
    }
}

struct PluginStateBadge: View {
    let state: PluginUIModel.State
    
    var body: some View {
        Group {
            switch state {
            case .new:
                Label("New", systemImage: "sparkles")
                    .font(.caption)
                    .fontWeight(.bold)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
            case .featured:
                Label("Featured", systemImage: "star.fill")
                    .font(.caption)
                    .fontWeight(.bold)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
            }
        }
    }
}

struct PluginVersionBadge: View {
    let version: String
    
    var body: some View {
        Text("v\(version)")
            .font(.caption)
            .fontWeight(.medium)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(Color.white.opacity(0.2))
            .foregroundColor(.white)
            .clipShape(Capsule())
    }
}