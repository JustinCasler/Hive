//
//  ContentView.swift
//  Hive
//
//  Created by justin casler on 4/20/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @StateObject var uploadViewModel = UploadPostViewModel()
    @StateObject var feedViewModel = FeedViewModel()
    @State private var selectedTab: Tab = .house
    @State private var showMenu: Bool = false
    init() {
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
        Group{
            if viewModel.userSession == nil {
                LoginView()
            }
            else {
                mainInterfaceView
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension ContentView {
    var mainInterfaceView: some View {
        ZStack{
            TabView(selection: $selectedTab){
                if selectedTab == .house {
                    FeedView(viewModel: feedViewModel, uploadViewModel: uploadViewModel)
                }
                if selectedTab == .person {
                    if let user = viewModel.currentUser {
                        ProfileView(user: user)
                    }
                }
            }
            VStack{
                Spacer()
                TabBar(selectedTab: $selectedTab, showMenu: $showMenu, viewModel: feedViewModel, uploadViewModel: uploadViewModel)
            }
        }
    }
}
