//
//  PostView.swift
//  Hive
//
//  Created by justin casler on 4/20/23.
//

import SwiftUI

struct PostView: View {
    @ObservedObject var viewModel: PostViewModel
    @State private var showFullDescription: Bool = false
    @State private var showPollView: Bool = false
    @State private var pollUpvotes = 0
    @State private var pollDownvotes = 0
    
    init(post: Post) {
        self.viewModel = PostViewModel(post: post)
    }
    var body: some View {
        VStack(alignment:.leading){
            if let user = viewModel.post.user {
                HStack(alignment:.center, spacing: 12){
                    NavigationLink{
                        ProfileView(user: user)
                    } label: {
                        Circle()
                            .frame(width:25, height: 25)
                            .foregroundColor(Color(colorStringToSwiftUIColor(user.color) ?? .systemBrown))
                    }
                    Text(viewModel.post.title)
                        .font(.headline).bold()
                        .font(.caption)
                    Spacer()
                    Text(timeSincePostCreation())
                        .font(.subheadline)
                }
            }
            VStack(alignment:.leading){
                Text(viewModel.post.caption)
                    .multilineTextAlignment(.leading)
                    .lineLimit(showFullDescription ? nil : 3)
                    .font(.subheadline)
                HStack{
                    Spacer()
                    Button(action:{
                        withAnimation(.easeInOut){
                            showFullDescription.toggle()
                        }
                    }, label: {
                        Image(systemName: showFullDescription == true ? "chevron.up" : "chevron.down")
                        
                    })
                    .padding(1)
                }
                
            }
            if let user = viewModel.post.user {
                HStack{
                    HStack{
                        Button {
                            if viewModel.post.didUpvote == true {
                                viewModel.unUpvote()
                            } else if (viewModel.post.didUpvote == false || viewModel.post.didUpvote == nil) && viewModel.post.didDownvote == true {
                                viewModel.upvote()
                                viewModel.unDownvote()
                            } else if (viewModel.post.didUpvote == false || viewModel.post.didUpvote == nil) && (viewModel.post.didDownvote == false || viewModel.post.didDownvote == nil) {
                                viewModel.upvote()                            }
                        } label: {
                            Image(systemName: "arrow.up")
                                .foregroundColor(viewModel.post.didUpvote ?? false ? .yellow : .gray)
                        }
                        Button{
                            if viewModel.post.didDownvote == true {
                                viewModel.unDownvote()
                            } else if (viewModel.post.didDownvote == false || viewModel.post.didDownvote == nil) && viewModel.post.didUpvote == true {
                                viewModel.downvote()
                                viewModel.unUpvote()
                            } else if (viewModel.post.didDownvote == false || viewModel.post.didDownvote == nil) && (viewModel.post.didUpvote == false || viewModel.post.didUpvote == nil) {
                                viewModel.downvote()
                            }
                        } label:{
                            Image(systemName:"arrow.down")
                                .foregroundColor(viewModel.post.didDownvote ?? false ? .yellow : .gray)
                        }
                    }.padding(.horizontal, 10)
                    HStack {
                        /*
                        Button{
                            
                        } label:{
                            Image(systemName:"bubble.right")
                        }.padding(.horizontal, 10)
                        */
                        
                        Button {
                            showPollView.toggle()
                        } label: {
                            Image(systemName: "chart.bar")
                        }.padding(.horizontal, 10)
                        Spacer()
                        NavigationLink{
                            ProfileView(user: user)
                        } label: {
                            Text("@\(user.username)")
                                .foregroundColor(.gray)
                                .font(.caption)
                                .padding(.vertical, 0)
                        }
                    }.foregroundStyle(.gray)
                }
            }
            if showPollView {
                PollView(agreeVotes: viewModel.upVotes, disagreeVotes: viewModel.downVotes)
                    .frame(height: 100)
                    //.transition(.move(edge: .bottom))
            }
        }
        .padding()
        .background(.thinMaterial)
        .cornerRadius(20)
        .onReceive(viewModel.$showPollView) { success in
            viewModel.fetchVotes()
            pollUpvotes = viewModel.post.upvote
            pollDownvotes = viewModel.post.downvote
        }
        
        
    }
    private func timeSincePostCreation() -> String {
        let timestamp = viewModel.post.timestamp.dateValue()
        let currentTime = Date()
        let calendar = Calendar.current
        
        if let days = calendar.dateComponents([.day], from: timestamp, to: currentTime).day, days > 0 {
            return "\(days) day\(days == 1 ? "" : "s") ago"
        } else if let hours = calendar.dateComponents([.hour], from: timestamp, to: currentTime).hour, hours > 0 {
            return "\(hours) hour\(hours == 1 ? "" : "s") ago"
        } else {
            return "Just now"
        }
    }
}
