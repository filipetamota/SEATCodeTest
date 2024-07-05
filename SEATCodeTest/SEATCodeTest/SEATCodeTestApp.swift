//
//  SEATCodeTestApp.swift
//  SEATCodeTest
//
//  Created by Filipe Mota on 3/7/24.
//

import SwiftUI
import SwiftData

@main
struct SEATCodeTestApp: App {
    var sharedModelContainer: ModelContainer = {
        var inMemory = false

        #if DEBUG
        if CommandLine.arguments.contains("enable-testing") {
            inMemory = true
        }
        #endif
        let schema = Schema([Issue.self])
        let config = ModelConfiguration(for: Issue.self, isStoredInMemoryOnly: inMemory)

        do {
            return try ModelContainer(for: schema, configurations: config)
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
