//
//  ExpandMindApp.swift
//  ExpandMind
//
//  Created by sanghyo on 2022/04/28.
//

import SwiftUI

@main
struct ExpandMindApp: App {
    @StateObject private var coreDataManager = CoreDataManager()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, coreDataManager.container.viewContext)
                        }
    }
}
