//
//  Plugin.swift
//  FinalCutPlugins
//
//  Created by Jade Lapuz on 7/1/25.
//

import Foundation

struct PluginAPIModel: Decodable, Identifiable {
    enum State: String, Decodable {
        case new
        case featured
    }
    
    struct SystemRequirements: Decodable {
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
}
