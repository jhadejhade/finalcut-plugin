//
//  MainViewModel.swift
//  FinalCutPlugins
//
//  Created by Jade Lapuz on 7/1/25.
//

import Foundation
import CoreData

protocol MainViewViewModelProtocol: Paginateable, Persistible {
    var plugins: [PluginUIModel] { get }
   
}

protocol Persistible {
    associatedtype Item: NSManagedObject
    func deleteItem(item: Item)
    func addItem(at index: Int) async throws
}

class MainViewViewModel: MainViewViewModelProtocol {

    @Published private(set) var plugins: [PluginUIModel] = []
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var isLoadingMore: Bool = false
    @Published private(set) var canLoadMore: Bool = true
    @Published private(set) var currentPage: Int = 1
    
    private var pluginService: ContentLoadable
    private let coreDataHelper: CoreDataHelper<PluginPersistenceObject>
    
    init(pluginService: ContentLoadable = PluginService.shared, viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.pluginService = pluginService
        self.coreDataHelper = CoreDataHelper<PluginPersistenceObject>(viewContext: viewContext)
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
    
    // MARK: - CoreData Operations (delegated to CoreDataHelper)
    
    func addItem(at index: Int) async throws {
        Task {
            let pluginUIModel = plugins[index]
            await coreDataHelper.createItem(configure: { item in
                item.from(pluginUIModel: pluginUIModel)
            })
        }
    }
    
    func deleteItem(item: PluginPersistenceObject) {
        
    }
}
