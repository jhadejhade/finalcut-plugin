//
//  PluginCardView.swift
//  FinalCutPlugins
//
//  Created by Jade Lapuz on 7/1/25.
//

import SwiftUI

struct PluginCardView<T: Persistible>: View {
    
    let plugin: PluginUIModel

    @State private var isDownloading = false
    @State private var isUninstalling = false
    @ObservedObject var viewModel: T
    
    var body: some View {
        HStack(spacing: 16) {
            // Plugin Image with Overlay
            ZStack(alignment: .bottomTrailing) {
                AsyncImage(url: plugin.imageUrl) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.gray.opacity(0.2))
                        .overlay(ShimmerView())
                }
                .frame(width: 80, height: 80)
                .clipShape(RoundedRectangle(cornerRadius: 12))

                Image(systemName: "puzzlepiece.extension")
                    .padding(6)
                    .background(Color.white.opacity(0.8))
                    .clipShape(Circle())
                    .offset(x: -4, y: -4)
            }

            // Plugin Info
            VStack(alignment: .leading, spacing: 10) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(plugin.name)
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                            .lineLimit(1)

                        HStack(spacing: 4) {
                            Image(systemName: "person.fill")
                                .foregroundColor(.gray)
                            Text(plugin.developer)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }

                    Spacer()

                    VStack(alignment: .trailing, spacing: 6) {
                        Text("v\(plugin.version)")
                            .font(.caption)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.blue.opacity(0.1))
                            .foregroundColor(.blue)
                            .clipShape(Capsule())

                        // State badge based on plugin state
                        switch plugin.state {
                        case .new:
                            Text("New")
                                .font(.caption2)
                                .fontWeight(.bold)
                                .padding(4)
                                .background(Color.green.opacity(0.2))
                                .foregroundColor(.green)
                                .clipShape(Capsule())
                        case .featured:
                            Text("Featured")
                                .font(.caption2)
                                .fontWeight(.bold)
                                .padding(4)
                                .background(Color.orange.opacity(0.2))
                                .foregroundColor(.orange)
                                .clipShape(Capsule())
                        }
                    }
                }

                Text(plugin.description)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(2)

                HStack {
                    Spacer()

                    Button(action: {
                        if plugin.isInstalled {
                            isUninstalling = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                viewModel.deleteItem(with: plugin.id)
                                isUninstalling = false
                            }
                        } else {
                            isDownloading = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                viewModel.addItem(uiModel: plugin as! T.UIModel)
                                isDownloading = false
                            }
                        }
                    }) {
                        HStack(spacing: 6) {
                            if plugin.isInstalled {
                                Image(systemName: isUninstalling ? "trash.circle" : "trash.circle.fill")
                                    .rotationEffect(.degrees(isUninstalling ? 360 : 0))
                                    .animation(isUninstalling ? .linear(duration: 1).repeatForever(autoreverses: false) : .default, value: isUninstalling)
                                    .font(.caption)
                                Text(isUninstalling ? "Uninstalling..." : "Uninstall")
                                    .font(.caption)
                                    .fontWeight(.medium)
                            } else {
                                Image(systemName: isDownloading ? "arrow.down.circle" : "arrow.down.circle.fill")
                                    .rotationEffect(.degrees(isDownloading ? 360 : 0))
                                    .animation(isDownloading ? .linear(duration: 1).repeatForever(autoreverses: false) : .default, value: isDownloading)
                                    .font(.caption)

                                Text(isDownloading ? "Downloading..." : "Download")
                                    .font(.caption)
                                    .fontWeight(.medium)
                            }
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(
                            plugin.isInstalled
                                ? LinearGradient(colors: [Color.red, Color.orange], startPoint: .leading, endPoint: .trailing)
                                : LinearGradient(colors: [Color.blue, Color.purple], startPoint: .leading, endPoint: .trailing)
                        )
                        .clipShape(Capsule())
                        .shadow(radius: 4)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .disabled(isDownloading || isUninstalling)
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(NSColor.controlBackgroundColor))
                .shadow(color: .black.opacity(0.08), radius: 10, x: 0, y: 6)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.gray.opacity(0.1), lineWidth: 0.5)
        )
    }
}

struct ShimmerView: View {
    @State private var phase: CGFloat = 0

    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(
                LinearGradient(
                    gradient: Gradient(colors: [.gray.opacity(0.3), .gray.opacity(0.1), .gray.opacity(0.3)]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .mask(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white)
                    .opacity(0.5)
            )
            .onAppear {
                withAnimation(.linear(duration: 1.2).repeatForever(autoreverses: false)) {
                    phase = 1
                }
            }
    }
}

#Preview {
    PluginCardView(plugin: PluginUIModel.mock, viewModel: MainViewViewModel())
}
