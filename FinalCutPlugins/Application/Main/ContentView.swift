//
//  ContentView.swift
//  Final Cut Plugins
//
//  Created by Jade Lapuz on 7/1/25.
//

import SwiftUI
import CoreData

struct ContentView<T: MainViewViewModelProtocol>: View {
    
    @StateObject var viewModel: T
    
    @State private var currentPage = 1

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.plugins) { plugin in
                    PluginCardView(plugin: plugin, viewModel: viewModel)
                        .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                        .listRowSeparator(.hidden)
                        .onAppear {
                            if plugin.id == viewModel.plugins.last?.id {
                                viewModel.loadMoreIfNeeded()
                            }
                        }
                }
                .loadingMore(viewModel.isLoadingMore)
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Final Cut Plugins")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        viewModel.sync()
                    } label: {
                        Image(systemName: "arrow.clockwise")
                    }
                    .disabled(viewModel.isSyncing)
                }
            }
            .loading(viewModel.isLoading, message: "Loading plugins...")
            .syncingIndicator(viewModel.isSyncing)
            .refreshable {
                viewModel.refreshData()
            }
            
            Text("Select a plugin")
        }
        .task {
            viewModel.refreshData()
        }
    }
}

#Preview {
    let viewModel = MainViewViewModel()
    ContentView(viewModel: viewModel)
}
