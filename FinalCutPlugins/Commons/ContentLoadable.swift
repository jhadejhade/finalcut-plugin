//
//  Paginateable.swift
//  FinalCutPlugins
//
//  Created by Jade Lapuz on 7/1/25.
//

import SwiftUI

protocol ContentLoadable: ObservableObject {
    var isLoading: Bool { get }
    var isLoadingMore: Bool { get }
    var isSyncing: Bool { get }
    var canLoadMore: Bool { get }
    var currentPage: Int { get }
    
    func fetchData(page: Int)
    func loadMoreIfNeeded()
    func refreshData()
    func sync()
}

extension ContentLoadable {
    func loadMoreIfNeeded() {
        guard canLoadMore,
              !isLoading,
              !isLoadingMore else {
            return
        }
        
        fetchData(page: currentPage + 1)
    }
    
    func refreshData() {
        fetchData(page: 1)
    }
}
