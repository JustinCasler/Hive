//
//  PostViewModel.swift
//  Hive
//
//  Created by justin casler on 6/24/23.
//

import Foundation
import SwiftUI

class PostViewModel: ObservableObject {
    @Published var post: Post
    @Published var showPollView: Bool = false
    @Published var upVotes: Int = 0
    @Published var downVotes: Int = 0
    private let service = PostService()
    let userService = UserService()
    
    init(post: Post) {
        self.post = post
        checkIfUserUpvote()
        checkIfUserDownvote()
        fetchUser()
    }
    private func fetchUser() {
        let uid = post.uid // Non-optional property

        userService.fetchUser(withUid: uid) { user in
            DispatchQueue.main.async {
                self.post.user = user
            }
        }
    }
    
    func upvote() {
        service.upvote(post) {
            self.post.didUpvote = true
            self.showPollView = true
        }
    }

    func unUpvote() {
        service.unUpvote(post) {
            self.post.didUpvote = false
            self.showPollView = true
        }
    }
    
    func downvote () {
        service.downvote(post) {
            self.post.didDownvote = true
            self.showPollView = true
        }
    }
    
    func unDownvote() {
        service.unDownvote(post) {
            self.post.didDownvote = false
            self.showPollView = true
        }
    }
    
    func checkIfUserUpvote() {
        service.checkIfUserUpvote(post) { didUpvote in
            if didUpvote {
                self.post.didUpvote = true
            }
        }
    }
    func checkIfUserDownvote() {
        service.checkIfUserDownvote(post) { didDownvote in
            if didDownvote{
                self.post.didDownvote = true
            }
        }
    }
    func fetchVotes(){
        upVotes = post.upvote
        downVotes = post.downvote
    }
}
