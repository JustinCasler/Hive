//
//  CreatePost.swift
//  Hive
//
//  Created by justin casler on 4/21/23.
//

import SwiftUI

struct CreatePost: View {
    @Binding var showCreatePost: Bool
    @State private var title = ""
    @State private var post = ""
    @State private var selectedTab: Tab = .play
    @ObservedObject var feedViewModel: FeedViewModel
    @ObservedObject var uploadViewModel: UploadPostViewModel
    
    var body: some View {
        VStack{
            HStack{
                Button{
                    showCreatePost.toggle()
                } label : {
                    Text("Cancel")
                }
                Spacer()
                Button{
                    uploadViewModel.uploadPost(withTitle: title, withCaption: post, withCategory: feedViewModel.category)
                } label : {
                    Text("Post")
                        .bold()
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(Color(.systemYellow))
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }
            }
            .padding()
            SecondaryHeaderView(feedViewModel: feedViewModel)
            
            TextField(
                "Title",
                text: $title,
                axis: .vertical
            )
            .textFieldStyle(.roundedBorder)
            .padding()
            TextField(
                "What's on your mind?",
                text: $post,
                axis: .vertical
            )
            .lineLimit(5, reservesSpace: true)
            .padding()
            .textFieldStyle(.roundedBorder)

            Spacer()
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        .background(.white)
            .onReceive(uploadViewModel.$didUploadPost) { success in
                if success {
                    showCreatePost.toggle()
                }
            }
    }
}

