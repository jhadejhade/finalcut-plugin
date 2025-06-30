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
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    @State private var currentPage = 1

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.plugins) { plugin in
                    PluginCardView(plugin: plugin)
                        .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                        .listRowSeparator(.hidden)
                        .onAppear {
                            if plugin.id == viewModel.plugins.last?.id {
                                viewModel.loadMoreIfNeeded()
                            }
                        }
                }
                .onDelete(perform: deleteItems)
                
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

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    let viewModel = MainViewViewModel()
    ContentView(viewModel: viewModel).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
