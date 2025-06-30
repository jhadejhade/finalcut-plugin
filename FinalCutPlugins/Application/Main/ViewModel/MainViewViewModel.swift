//
//  MainViewModel.swift
//  FinalCutPlugins
//
//  Created by Jade Lapuz on 7/1/25.
//

import Foundation

protocol MainViewViewModelProtocol: Paginateable {
    var plugins: [PluginUIModel] { get }
}

class MainViewViewModel: MainViewViewModelProtocol {

    @Published private(set) var plugins: [PluginUIModel] = []
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var isLoadingMore: Bool = false
    @Published private(set) var canLoadMore: Bool = true
    @Published private(set) var currentPage: Int = 1
    
    private var pluginService: ContentLoadable
    
    init(pluginService: ContentLoadable = PluginService.shared) {
        self.pluginService = pluginService
    }
    
    func fetchData(page: Int) {
        if page == 1 {
            isLoading = true
            canLoadMore = true
        } else {
            isLoadingMore = true
        }
        
        Task {
            do {
                let result: [PluginAPIModel] = try await pluginService.fetchData(page: page)
                
                await MainActor.run {
                    isLoading = false
                    isLoadingMore = false
                    
                    let pluginUIModels = result.map { PluginUIModel(pluginAPIModel: $0) }
                    
                    if page > 1 {
                        plugins.append(contentsOf: pluginUIModels)
                    } else {
                        self.plugins = pluginUIModels
                    }
                    
                    canLoadMore = !result.isEmpty
                    currentPage = page
                }
            } catch {
                await MainActor.run {
                    isLoading = false
                    isLoadingMore = false
                }
                print("Error fetching data: \(error)")
            }
        }
    }
}
