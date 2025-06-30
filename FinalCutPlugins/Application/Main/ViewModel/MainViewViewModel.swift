//
//  MainViewModel.swift
//  FinalCutPlugins
//
//  Created by Jade Lapuz on 7/1/25.
//

import Foundation
import CoreData

protocol MainViewViewModelProtocol: ContentLoadable, Persistible {
    var plugins: [PluginUIModel] { get }
}

protocol UIPersistibleObject { }

protocol Persistible: ObservableObject {
    associatedtype UIModel: UIPersistibleObject
    
    func deleteItem(with id: String)
    func addItem(uiModel: UIModel)
}

class MainViewViewModel: MainViewViewModelProtocol {

    @Published private(set) var plugins: [PluginUIModel] = []
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var isLoadingMore: Bool = false
    @Published private(set) var canLoadMore: Bool = true
    @Published private(set) var currentPage: Int = 1
    @Published private(set) var isSyncing: Bool = false
    
    private var pluginService: FetchService
    private let coreDataHelper: CoreDataHelper<PluginPersistenceObject>
    
    init(pluginService: FetchService = PluginService.shared, viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.pluginService = pluginService
        self.coreDataHelper = CoreDataHelper<PluginPersistenceObject>(viewContext: viewContext)
    }
    
    func sync() {
        isSyncing = true
        Task {
            do {
                let result: [PluginAPIModel] = try await pluginService.sync()
                
                let pluginUIModels = result.map { plugin in
                    PluginUIModel(
                        pluginAPIModel: plugin,
                        isInstalled: false
                    )
                }
                
                await MainActor.run {
                    plugins = pluginUIModels
                    isSyncing = false
                }
            } catch {
                await MainActor.run {
                    isSyncing = false
                }
            }
        }
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
                
                let installedPlugins = try await coreDataHelper.fetchItems(
                    predicate: NSPredicate(format: "isInstalled == YES")
                )
                
                let installedPluginIds = Set(installedPlugins.compactMap { $0.id })
                
                await MainActor.run {
                    isLoading = false
                    isLoadingMore = false
                    
                    let pluginUIModels = result.map { plugin in
                        PluginUIModel(
                            pluginAPIModel: plugin,
                            isInstalled: installedPluginIds.contains(plugin.id)
                        )
                    }
                    
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
    
    func addItem(uiModel: PluginUIModel) {
        Task {
            let predicate = NSPredicate(format: "id == %@", uiModel.id)
            await coreDataHelper.createOrUpdateItem(predicate: predicate) { item in
                item.from(pluginUIModel: uiModel)
            }
        }
    }
    
    func deleteItem(with id: String) {
        Task {
            await coreDataHelper.deleteItem(with: id)
        }
    }
}
