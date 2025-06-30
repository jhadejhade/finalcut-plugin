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
                
                if viewModel.isLoadingMore {
                    HStack {
                        Spacer()
                        ProgressView()
                            .scaleEffect(0.8)
                        Text("Loading more...")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                    .listRowInsets(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
                    .listRowSeparator(.hidden)
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Final Cut Plugins")
            .loading(viewModel.isLoading, message: "Loading plugins...")
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
