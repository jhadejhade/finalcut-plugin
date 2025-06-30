//
//  PluginDetailView.swift
//  FinalCutPlugins
//
//  Created by Jade Lapuz on 7/1/25.
//

import SwiftUI

struct PluginDetailView<T: Persistible>: View {
    let plugin: PluginUIModel
    @ObservedObject var viewModel: T
    @Environment(\.dismiss) private var dismiss
    
    @State private var isDownloading = false
    @State private var isUninstalling = false
    @State private var showingInstallConfirmation = false
    @State private var showingUninstallConfirmation = false
    @State private var scrollOffset: CGFloat = 0
    @State private var showFullDescription = false
    @State private var selectedScreenshot = 0
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 0) {
                    // Hero Header Section
                    PluginHeroHeaderView(plugin: plugin, scrollOffset: scrollOffset)
                    
                    // Content Section
                    VStack(spacing: 24) {
                        
                        // Description Section
                        PluginDescriptionView(
                            plugin: plugin,
                            showFullDescription: $showFullDescription
                        )
                        
                        // Screenshots Section
                        PluginScreenshotsView(selectedScreenshot: $selectedScreenshot)
                        
                        // Features Section
                        PluginFeaturesView()
                        
                        // System Requirements Section
                        PluginSystemRequirementsView()
                        
                        // Additional Info Section
                        PluginAdditionalInfoView()
                    }
                    .background(Color(NSColor.windowBackgroundColor))
                    .padding(.top)
                }
            }
            .coordinateSpace(name: "scroll")
            .background(
                GeometryReader { proxy in
                    Color.clear
                        .preference(key: ScrollOffsetPreferenceKey.self,
                                   value: proxy.frame(in: .named("scroll")).minY)
                }
            )
            .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                scrollOffset = value
            }
        }
        .navigationTitle(plugin.name)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Button("Close") {
                    dismiss()
                }
            }
        }
        .confirmationDialog("Install Plugin", isPresented: $showingInstallConfirmation) {
            Button("Install") {
                performInstall()
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure you want to install \(plugin.name)?")
        }
        .confirmationDialog("Uninstall Plugin", isPresented: $showingUninstallConfirmation) {
            Button("Uninstall", role: .destructive) {
                performUninstall()
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure you want to uninstall \(plugin.name)?")
        }
    }
    
    private func performInstall() {
        isDownloading = true
        
        withAnimation(.easeInOut(duration: 2.0)) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                viewModel.addItem(uiModel: plugin as! T.UIModel)
                plugin.isInstalled = true
                isDownloading = false
            }
        }
    }
    
    private func performUninstall() {
        isUninstalling = true
        
        withAnimation(.easeInOut(duration: 1.0)) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                viewModel.deleteItem(with: plugin.id)
                plugin.isInstalled = false
                isUninstalling = false
            }
        }
    }
}

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

#Preview {
    NavigationView {
        PluginDetailView(plugin: PluginUIModel.mock, viewModel: MainViewViewModel())
    }
}
