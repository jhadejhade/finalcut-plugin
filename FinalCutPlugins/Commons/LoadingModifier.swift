//
//  LoadingModifier.swift
//  FinalCutPlugins
//
//  Created by Jade Lapuz on 7/1/25.
//

import SwiftUI

struct LoadingModifier: ViewModifier {
    let isLoading: Bool
    let message: String
    let scale: CGFloat
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .opacity(isLoading ? 0 : 1)
            
            if isLoading {
                VStack(spacing: 16) {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(scale)
                    
                    Text(message)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}

struct SyncingIndicatorModifier: ViewModifier {
    let isSyncing: Bool
    
    func body(content: Content) -> some View {
        VStack(spacing: 0) {
            if isSyncing {
                HStack {
                    ProgressView()
                        .scaleEffect(0.8)
                    Text("Syncing...")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
            }
            
            content
        }
    }
}

struct LoadingMoreModifier: ViewModifier {
    let isLoadingMore: Bool
    
    func body(content: Content) -> some View {
        Group {
            content
            
            if isLoadingMore {
                HStack {
                    Spacer()
                    ProgressView()
                        .scaleEffect(0.8)
                    Text("Loading more...")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Spacer()
                }
                .listRowInsets(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
                .listRowSeparator(.hidden)
            }
        }
    }
}

extension View {
    func loading(
        _ isLoading: Bool,
        message: String = "Loading...",
        scale: CGFloat = 1.2
    ) -> some View {
        modifier(LoadingModifier(
            isLoading: isLoading,
            message: message,
            scale: scale
        ))
    }
    
    func syncingIndicator(_ isSyncing: Bool) -> some View {
        modifier(SyncingIndicatorModifier(isSyncing: isSyncing))
    }
    
    func loadingMore(_ isLoadingMore: Bool) -> some View {
        modifier(LoadingMoreModifier(isLoadingMore: isLoadingMore))
    }
}
