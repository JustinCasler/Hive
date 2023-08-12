//
//  FeedView.swift
//  Hive
//
//  Created by justin casler on 4/20/23.
//

import SwiftUI

struct FeedView: View {
    @ObservedObject var viewModel: FeedViewModel
    @StateObject var headerData = HeaderViewModel()
    @ObservedObject var uploadViewModel: UploadPostViewModel
    @State private var scrollPosition: CGFloat = 0.0
    
    var body: some View {
        ZStack{
            ZStack(alignment: .top){
                VStack{
                    HeaderView()
                        .zIndex(2)
                    SecondaryHeaderView(feedViewModel: viewModel)
                        .zIndex(1)
                        .offset(y: headerData.headerOffset)
                    Spacer()
                }
                .zIndex(1)
                ScrollView{
                    LazyVStack{
                        ForEach(viewModel.posts) { post in
                            PostView(post: post)
                                .padding()
                        }
                    }
                    .padding(.top, 120)
                }
            }
        }
        .onReceive(uploadViewModel.$feedDidUploadPost) { success in
            if success == true {
                viewModel.fetchPosts(forCategory: viewModel.category)
                uploadViewModel.feedDidUploadPost = false
            }
        }
        .onReceive(viewModel.$fetchCategory) { success in
            if success {
                viewModel.fetchPosts(forCategory: viewModel.category)
            }
        }
        .onAppear{
            viewModel.fetchPosts(forCategory: viewModel.category)
        }
    }
}


/*
 
 func getMaxOffset()->CGFloat {
     return headerData.startMinY
 }
 
.overlay(
    GeometryReader { proxy -> Color in
        let minY = proxy.frame(in: .global).minY

        DispatchQueue.main.async {
            if headerData.startMinY == 0 {
                headerData.startMinY = minY
            }
            let offset = headerData.startMinY - CGFloat(minY)

            if offset > headerData.offset {
                
                headerData.bottomScrollOffset = 0
                
                if headerData.topScrollOffset == 0 {
                    headerData.topScrollOffset = offset
                }
                
                let progress = (headerData.topScrollOffset + getMaxOffset()) - offset
                let offsetCondition = (headerData.topScrollOffset + getMaxOffset()) >= getMaxOffset() && getMaxOffset() - progress <= getMaxOffset()
                let headerOffset = offsetCondition ? -(getMaxOffset() - progress) : -getMaxOffset()
                headerData.headerOffset = headerOffset
            }
            if offset < headerData.offset {
                headerData.topScrollOffset = 0
                if headerData.bottomScrollOffset == 0 {
                    headerData.bottomScrollOffset = offset
                }
                withAnimation(.easeOut(duration: 0.25)){
                    let headerOffset = headerData.headerOffset
                    
                    headerData.headerOffset = headerData.bottomScrollOffset > offset + 40 ? 0 : (headerOffset != -getMaxOffset() ? 0 : headerOffset)
                }
            }
            headerData.offset = offset
        }

        return Color.clear
    }
    .frame(height: 0)
    ,alignment: .top
) */

