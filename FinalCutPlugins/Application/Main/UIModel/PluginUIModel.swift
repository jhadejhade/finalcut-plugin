//
//  PluginAPIModel.swift
//  FinalCutPlugins
//
//  Created by Jade Lapuz on 7/1/25.
//

import Foundation

class PluginUIModel: Identifiable, UIPersistibleObject {
    enum State: String {
        case new
        case featured
    }
    
    let id: String
    let name: String
    let developer: String
    let version: String
    let description: String
    let downloadUrl: URL
    let imageUrl: URL
    let state: State
    @Published var isInstalled: Bool
    
    init(pluginAPIModel: PluginAPIModel) {
        self.id = pluginAPIModel.id
        self.name = pluginAPIModel.name
        self.developer = pluginAPIModel.developer
        self.version = pluginAPIModel.version
        self.description = pluginAPIModel.description
        self.downloadUrl = pluginAPIModel.downloadUrl
        self.imageUrl = pluginAPIModel.imageUrl
        self.state = State(rawValue: pluginAPIModel.state.rawValue) ?? .new
        self.isInstalled = false
    }
    
    init(pluginAPIModel: PluginAPIModel, isInstalled: Bool) {
        self.id = pluginAPIModel.id
        self.name = pluginAPIModel.name
        self.developer = pluginAPIModel.developer
        self.version = pluginAPIModel.version
        self.description = pluginAPIModel.description
        self.downloadUrl = pluginAPIModel.downloadUrl
        self.imageUrl = pluginAPIModel.imageUrl
        self.state = (State(rawValue: pluginAPIModel.state.rawValue) ?? .new)
        self.isInstalled = isInstalled
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
                state: .new
            )
        )
    }
}
