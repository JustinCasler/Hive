//
//  HiveApp.swift
//  Hive
//
//  Created by justin casler on 4/20/23.
//

import SwiftUI
import Firebase

@main
struct HiveApp: App {
    @StateObject var viewModel = AuthViewModel()
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ContentView()
            }
            .environmentObject(viewModel)
        }
    }
}
