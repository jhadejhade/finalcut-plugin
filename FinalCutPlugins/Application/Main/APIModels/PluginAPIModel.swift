//
//  Plugin.swift
//  FinalCutPlugins
//
//  Created by Jade Lapuz on 7/1/25.
//

import Foundation

struct PluginAPIModel: Codable, Identifiable {
    let id: String
    let name: String
    let developer: String
    let version: String
    let description: String
    let downloadUrl: URL
    let imageUrl: URL
}
