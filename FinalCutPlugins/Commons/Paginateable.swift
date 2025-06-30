//
//  Paginateable.swift
//  FinalCutPlugins
//
//  Created by Jade Lapuz on 7/1/25.
//

import SwiftUI

protocol Paginateable: ObservableObject {
    var isLoading: Bool { get }
    var isLoadingMore: Bool { get }
    var canLoadMore: Bool { get }
    var currentPage: Int { get }
    
    func fetchData(page: Int)
    func loadMoreIfNeeded()
    func refreshData()
}

extension Paginateable {
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
