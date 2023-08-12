//
//  ProfileView.swift
//  social_media
//
//  Created by justin casler on 4/15/23.
//

import SwiftUI

struct ProfileView: View {
    @State private var selectedFilter: FilterViewModel = .posts
    @ObservedObject var viewModel: ProfileViewModel
    @Namespace var animation
    @Environment(\.presentationMode) var mode
    @EnvironmentObject var authViewModel: AuthViewModel
    
    init(user: User) {
        self.viewModel = ProfileViewModel(user: user)
    }
    
    var body: some View {
        ZStack{
            VStack{
                VStack(alignment: .leading) {
                    headerView
                    
                    actionbuttons
                    
                    userInfoDetails
                    
                    filterBar
                    ScrollView{
                        LazyVStack(alignment: .leading){
                            ForEach(viewModel.posts(forFilter: self.selectedFilter)) { post in
                                PostView(post: post)
                                    .padding()
                            }
                        }
                    }
                    Spacer()
                }
            }
        }
    }
}



extension ProfileView {
    var headerView: some View {
        ZStack{
            Color(.systemYellow)
                .ignoresSafeArea()
            HStack(){
                if !viewModel.isCurrentUser {
                    Button{
                        mode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .frame(width:20, height:16)
                            .foregroundColor(.white)
                    }.navigationBarBackButtonHidden(true)
                } else {
                    Button{
                        
                    } label: {
                        Image(systemName: "arrow.left")
                            .frame(width:20, height:16)
                            .foregroundColor(.clear)
                    }.navigationBarBackButtonHidden(true)
                }
                Circle()
                    .frame(width:72, height:72)
                    .offset(x:-5, y:30)
                    .foregroundColor(Color(colorStringToSwiftUIColor(viewModel.user.color) ?? .systemBrown))
                Spacer()
            }
            .padding()

        }
        .frame(height:96)
    }
    
    var actionbuttons: some View {
        if viewModel.isCurrentUser {
            return AnyView(
                HStack(spacing: 12) {
                    Spacer()
                    
                    Button(action: {
                        authViewModel.signOut()
                    }) {
                        Text("Sign Out")
                            .font(.subheadline).bold()
                            .frame(width: 120, height: 32)
                            .foregroundColor(.black)
                            .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 0.75))
                    }
                }
                .padding(.trailing)
            )
        } else {
            return AnyView(
                HStack(spacing: 12) {
                    Spacer()
                    
                    Button(action: {

                    }) {
                        Text("")
                            .font(.subheadline).bold()
                            .frame(width: 120, height: 32)
                            .foregroundColor(.clear)
                            .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.clear, lineWidth: 0.75))
                    }
                }
                .padding(.trailing)
            )
        }
    }
    
    var userInfoDetails: some View{
        VStack(alignment:.leading, spacing: 4){
            HStack{
                Text(viewModel.user.username)
                    .font(.title2).bold()
            }
        }
        .padding()
    }
    
    var filterBar: some View{
        HStack{
            ForEach(FilterViewModel.allCases, id: \.rawValue){ item in
                VStack{
                    Text(item.title)
                        .font(.subheadline)
                        .fontWeight(selectedFilter == item ? .semibold : .regular)
                        .foregroundColor(selectedFilter == item ? .black : .gray )
                    if selectedFilter == item{
                        Capsule()
                            .foregroundColor(Color(.black))
                            .frame(height: 3)
                            .matchedGeometryEffect(id: "filter", in: animation, properties: .frame, anchor: .bottomLeading, isSource: selectedFilter == item)
                    } else {
                        Capsule()
                            .foregroundColor(Color(.clear))
                            .frame(height: 3)
                    }
                }
                .onTapGesture {
                    withAnimation(.easeInOut){
                        self.selectedFilter = item
                    }
                }
            }
        }
        .overlay(Divider().offset(x: 0, y: 16))
    }
}
