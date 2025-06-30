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
    var isLoading: Bool { get }
}

class MainViewViewModel: MainViewViewModelProtocol {

    @Published private(set) var plugins: [PluginUIModel] = []
    @Published private(set) var isLoading: Bool = false
    
    private var pluginService: ContentLoadable
    
    init(pluginService: ContentLoadable = PluginService.shared) {
        self.pluginService = pluginService
    }
    
    func fetchData(page: Int) {
        isLoading = true
        Task {
            do {
                let result: [PluginAPIModel] = try await pluginService.fetchData(page: page)
                
                await MainActor.run {
                    isLoading = false
                    self.plugins = result.map { PluginUIModel(pluginAPIModel: $0) }
                    
                }
            } catch {
                isLoading = false
                print("Error fetching data: \(error)")
            }
        }
    }
}
