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
}
