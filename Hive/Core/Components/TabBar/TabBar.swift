//
//  TabBar.swift
//  Hive
//
//  Created by justin casler on 4/20/23.
//

import SwiftUI

enum Tab: String, CaseIterable{
    case house
    case play
    case person
}

struct TabBar: View {
    @Binding var selectedTab: Tab
    @Binding var showMenu: Bool
    @ObservedObject var viewModel: FeedViewModel
    @ObservedObject var uploadViewModel: UploadPostViewModel
    private var fillImage: String {
        selectedTab.rawValue + ".fill"
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                Spacer()
                ZStack{
                    HStack{
                        ForEach(Tab.allCases, id: \.rawValue){ tab in
                            Spacer()
                            Image(systemName: selectedTab == tab ? fillImage : tab.rawValue)
                                .scaleEffect(tab == selectedTab ? 1.25 : 1.0)
                                .onTapGesture {
                                    withAnimation(.easeIn(duration: 0.1)){
                                        if showMenu {
                                            showMenu = false
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                                                selectedTab = tab
                                            }
                                        } else {
                                            selectedTab = tab
                                        }
                                    }
                                }
                            Spacer()
                        }
                    }
                    .frame(width:nil, height: 60)
                    .background(.thinMaterial)
                    .cornerRadius(30)
                    .padding()
                    
                    TabMenuIcon(showMenu: $showMenu)
                        .onTapGesture {
                            withAnimation{
                                showMenu.toggle()
                                uploadViewModel.didUploadPost = false
                            }
                        }
                    
                }
            }
            
            if showMenu {
                CreatePost(showCreatePost: $showMenu, feedViewModel: viewModel, uploadViewModel: uploadViewModel)
                       .transition(.move(edge: .bottom))
                       .animation(.easeInOut)
                       .zIndex(-1)
                       .onDisappear {
                           withAnimation(
                               Animation.easeOut(duration: 0.2) // leaving animation
                           ) {
                               showMenu = false
                           }
                       }
            }
        }
    }
}




struct TabMenuIcon: View{
    @Binding var showMenu: Bool
    var body: some View{
        ZStack{
            Circle()
                .foregroundColor(.white)
                .frame(width:56, height: 56)
                .shadow(radius: 4)
            Image(systemName: "plus.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .foregroundColor(Color(.systemYellow))
                .rotationEffect(Angle(degrees: showMenu ? 135 : 0))
        }
        .offset(y: -20)
    }
}


