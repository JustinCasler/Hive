//
//  TabBarButton.swift
//  Hive
//
//  Created by justin casler on 4/24/23.
//
/*
import SwiftUI

struct TabBarButton: View {
    @State private var showMenu = false
    @ObservedObject var router = ViewRouter()
    var body: some View {
        VStack{
            Spacer()
            router.view
            ZStack{
                HStack{
                    TabIcon(viewModel: .home, router: router)
                    
                    TabIcon(viewModel: .account, router: router)
                }
                .frame(width:nil, height: 60)
                .background(.thinMaterial)
                .cornerRadius(30)
                .padding()
                TabMenuIcon(showMenu: $showMenu)
                    .onTapGesture {
                        withAnimation{
                            showMenu.toggle()
                        }
                    }
            }.background(.clear)
        }
    }
}


struct TabIcon: View {
    let viewModel: TabBarViewModel
    @ObservedObject var router: ViewRouter
    var body: some View{
        Button{
            router.currentItem = viewModel
        } label : {
            Image(systemName: viewModel.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 20, height: 20)
                .frame(maxWidth:. infinity)
                .foregroundColor(.black)
        }
    }
}


struct TabBarButton_Previews: PreviewProvider {
    static var previews: some View {
        TabBarButton(router: ViewRouter())
    }
} */
