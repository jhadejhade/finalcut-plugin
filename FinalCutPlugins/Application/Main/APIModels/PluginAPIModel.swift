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
}
