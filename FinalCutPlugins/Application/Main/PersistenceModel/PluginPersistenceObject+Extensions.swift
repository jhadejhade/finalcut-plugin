//
//  PluginPersistenceModel+Extensions.swift
//  FinalCutPlugins
//
//  Created by Jade Lapuz on 7/1/25.
//

import CoreData
import Foundation

extension PluginPersistenceObject {
    func from(pluginUIModel: PluginUIModel) {
        self.id = pluginUIModel.id
        self.name = pluginUIModel.name
        self.developer = pluginUIModel.developer
        self.version = pluginUIModel.version
        self.information = pluginUIModel.description
        self.downloadURL = pluginUIModel.downloadUrl.absoluteString
        self.state = pluginUIModel.state.rawValue
        self.isInstalled = true
        self.timestamp = Date()
    }
}
