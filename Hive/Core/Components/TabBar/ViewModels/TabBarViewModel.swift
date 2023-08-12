//
//  TabBarViewModel.swift
//  Hive
//
//  Created by justin casler on 4/25/23.
//

import SwiftUI
/*
class ViewRouter: ObservableObject {
    @Published var currentItem: TabBarViewModel = .home
    
    var view: AnyView {return currentItem.view}
}

enum TabBarViewModel: Int, CaseIterable{
    case home
    case account
    
    var imageName: String {
        switch self {
        case .home: return "house.fill"
        case .account: return "person.fill"
        }
    }
    
    var view: AnyView {
        @EnvironmentObject var viewModel: AuthViewModel
        
        switch self {
        case .home:
            return AnyView(FeedView(uploadViewModel: uploadViewModel))
        
        case .account:
            if let user = viewModel.currentUser {
                return AnyView(ProfileView(user: user))
            }
            else {
                return AnyView(FeedView(uploadViewModel: uploadViewModel))
            }
         
        }
    }
    
} */
