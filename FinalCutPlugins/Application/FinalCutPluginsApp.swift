//
//  FinalCutPluginsApp.swift
//  FinalCutPlugins
//
//  Created by Jade Lapuz on 7/1/25.
//

import SwiftUI

@main
struct FinalCutPluginsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            let viewModel = MainViewViewModel()
            ContentView(viewModel: viewModel)
        }
        .defaultSize(width: 2000, height: 1000)
        .defaultPosition(.center)
        .windowResizability(.contentSize)
    }
}
