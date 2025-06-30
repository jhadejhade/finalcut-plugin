//
//  MainViewModel.swift
//  FinalCutPlugins
//
//  Created by Jade Lapuz on 7/1/25.
//

import Foundation

protocol Paginateable: ObservableObject {
    func fetchData(page: Int)
}

protocol MainViewViewModelProtocol: Paginateable {
    var plugins: [PluginUIModel] { get }
}

class MainViewViewModel: MainViewViewModelProtocol {

    @Published private(set) var plugins: [PluginUIModel] = []
    
    private var pluginService: ContentLoadable
    
    init(pluginService: ContentLoadable = PluginService.shared) {
        self.pluginService = pluginService
    }
    
    func fetchData(page: Int) {
        Task {
            let result: [PluginAPIModel] = try await pluginService.fetchData(page: page)
            
            self.plugins = result.map { PluginUIModel(pluginAPIModel: $0) }
        }
    }
}
