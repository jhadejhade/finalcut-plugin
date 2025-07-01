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
    
    struct SystemRequirements {
        let macOS: String
        let finalCutPro: String
        let memory: String
        let graphics: String
        let processor: String
        let storage: String
    }
    
    let id: String
    let name: String
    let developer: String
    let version: String
    let description: String
    let downloadUrl: URL
    let imageUrl: URL
    let state: State
    let category: String
    let size: String
    let updated: String
    let language: String
    let compatibility: String
    let price: String
    let features: [String]
    let systemRequirements: SystemRequirements
    let screenshots: [URL]
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
        self.category = pluginAPIModel.category
        self.size = pluginAPIModel.size
        self.updated = pluginAPIModel.updated
        self.language = pluginAPIModel.language
        self.compatibility = pluginAPIModel.compatibility
        self.price = pluginAPIModel.price
        self.features = pluginAPIModel.features
        self.systemRequirements = SystemRequirements(
            macOS: pluginAPIModel.systemRequirements.macOS,
            finalCutPro: pluginAPIModel.systemRequirements.finalCutPro,
            memory: pluginAPIModel.systemRequirements.memory,
            graphics: pluginAPIModel.systemRequirements.graphics,
            processor: pluginAPIModel.systemRequirements.processor,
            storage: pluginAPIModel.systemRequirements.storage
        )
        self.screenshots = pluginAPIModel.screenshots
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
        self.category = pluginAPIModel.category
        self.size = pluginAPIModel.size
        self.updated = pluginAPIModel.updated
        self.language = pluginAPIModel.language
        self.compatibility = pluginAPIModel.compatibility
        self.price = pluginAPIModel.price
        self.features = pluginAPIModel.features
        self.systemRequirements = SystemRequirements(
            macOS: pluginAPIModel.systemRequirements.macOS,
            finalCutPro: pluginAPIModel.systemRequirements.finalCutPro,
            memory: pluginAPIModel.systemRequirements.memory,
            graphics: pluginAPIModel.systemRequirements.graphics,
            processor: pluginAPIModel.systemRequirements.processor,
            storage: pluginAPIModel.systemRequirements.storage
        )
        self.screenshots = pluginAPIModel.screenshots
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
                state: .new,
                category: "Color Grading",
                size: "124 MB",
                updated: "Dec 15, 2024",
                language: "English",
                compatibility: "Final Cut Pro 10.5+",
                price: "$99.99",
                features: [
                    "Professional Color Wheels",
                    "Advanced Curves",
                    "LUT Support",
                    "Real-time Preview"
                ],
                systemRequirements: PluginAPIModel.SystemRequirements(
                    macOS: "macOS 11.0 or later",
                    finalCutPro: "Final Cut Pro 10.5 or later",
                    memory: "8GB RAM minimum, 16GB recommended",
                    graphics: "Metal-compatible graphics card",
                    processor: "Intel Core i5 or Apple Silicon M1/M2",
                    storage: "300MB available space"
                ),
                screenshots: [
                    URL(string: "https://via.placeholder.com/800x450?text=Screenshot+1")!,
                    URL(string: "https://via.placeholder.com/800x450?text=Screenshot+2")!,
                    URL(string: "https://via.placeholder.com/800x450?text=Screenshot+3")!
                ]
            )
        )
    }
}
