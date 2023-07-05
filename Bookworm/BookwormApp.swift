//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Boubacar sidiki barry on 04.07.23.
//

import SwiftUI

@main
struct BookwormApp: App {
    
    @StateObject var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext,dataController.container.viewContext)
        }
    }
}
