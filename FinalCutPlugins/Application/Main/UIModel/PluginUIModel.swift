//
//  PluginAPIModel.swift
//  FinalCutPlugins
//
//  Created by Jade Lapuz on 7/1/25.
//

import Foundation

struct PluginUIModel {
    let id: String
    let name: String
    let developer: String
    let version: String
    let description: String
    let downloadUrl: URL
    let imageUrl: URL
    
    init(pluginAPIModel: PluginAPIModel) {
        self.id = pluginAPIModel.id
        self.name = pluginAPIModel.name
        self.developer = pluginAPIModel.developer
        self.version = pluginAPIModel.version
        self.description = pluginAPIModel.description
        self.downloadUrl = pluginAPIModel.downloadUrl
        self.imageUrl = pluginAPIModel.imageUrl
    }
}
