//
//  PluginAPIModel.swift
//  FinalCutPlugins
//
//  Created by Jade Lapuz on 7/1/25.
//

import Foundation

struct PluginUIModel: Identifiable {
    enum State: String {
        case new
        case featured
        case installed
    }
    
    let id: String
    let name: String
    let developer: String
    let version: String
    let description: String
    let downloadUrl: URL
    let imageUrl: URL
    let state: State
    
    init(pluginAPIModel: PluginAPIModel) {
        self.id = pluginAPIModel.id
        self.name = pluginAPIModel.name
        self.developer = pluginAPIModel.developer
        self.version = pluginAPIModel.version
        self.description = pluginAPIModel.description
        self.downloadUrl = pluginAPIModel.downloadUrl
        self.imageUrl = pluginAPIModel.imageUrl
        self.state = State(rawValue: pluginAPIModel.state.rawValue) ?? .new
    }
    
    static var mock: PluginUIModel {
        PluginUIModel(
            pluginAPIModel: PluginAPIModel(
                id: "mock-plugin-1",
                name: "Color Corrector Pro",
                developer: "FinalCut Studios",
                version: "2.1.0",
                description: "Professional color correction and grading plugin with advanced tools for cinematic looks.",
                downloadUrl: URL(string: "https://example.com/download/color-corrector-pro")!,
                imageUrl: URL(string: "https://example.com/images/color-corrector-pro.png")!,
                state: .installed
            )
        )
    }
}
