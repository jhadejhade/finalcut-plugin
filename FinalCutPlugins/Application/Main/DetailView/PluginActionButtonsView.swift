//
//  PluginActionButtonsView.swift
//  FinalCutPlugins
//
//  Created by Jade Lapuz on 7/1/25.
//

import SwiftUI

struct PluginActionButtonsView<T: Persistible>: View {
    let plugin: PluginUIModel
    @ObservedObject var viewModel: T
    
    @Binding var showingInstallConfirmation: Bool
    @Binding var showingUninstallConfirmation: Bool
    @Binding var isDownloading: Bool
    @Binding var isUninstalling: Bool
    
    var body: some View {
        HStack(spacing: 16) {
            Button(action: {
                if plugin.isInstalled {
                    showingUninstallConfirmation = true
                } else {
                    showingInstallConfirmation = true
                }
            }) {
                HStack(spacing: 8) {
                    Image(systemName: plugin.isInstalled ? "trash.circle.fill" : "arrow.down.circle.fill")
                        .font(.title3)
                    Text(plugin.isInstalled ? "Uninstall" : "Install")
                        .font(.headline)
                        .fontWeight(.semibold)
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(
                    plugin.isInstalled
                        ? LinearGradient(colors: [Color.red, Color.orange], startPoint: .leading, endPoint: .trailing)
                        : LinearGradient(colors: [Color.blue, Color.purple], startPoint: .leading, endPoint: .trailing)
                )
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .shadow(color: plugin.isInstalled ? Color.red.opacity(0.3) : Color.blue.opacity(0.3), radius: 8, x: 0, y: 4)
            }
            .disabled(isDownloading || isUninstalling)
            
            Button(action: {
                // Share functionality
            }) {
                Image(systemName: "square.and.arrow.up")
                    .font(.title3)
                    .foregroundColor(.primary)
                    .frame(width: 54, height: 54)
                    .background(Color(NSColor.controlBackgroundColor))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(radius: 2)
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
    }
}