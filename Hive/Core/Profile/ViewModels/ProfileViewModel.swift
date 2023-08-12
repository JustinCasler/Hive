//
//  ProfileViewModel.swift
//  Hive
//
//  Created by justin casler on 6/24/23.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var posts = [Post]()
    @Published var upVotedPosts = [Post]()
    @Published var downVotedPosts = [Post]()
    private let service = PostService()
    private let userService = UserService()
    
    let user: User
    
    init(user: User){
        self.user = user
        self.fetchUserPosts()
        self.fetchUpvotedPosts()
        self.fetchDownvotedPosts()
    }
    
    var isCurrentUser: Bool {
        return user.isCurrentUser
    }
    
    func posts(forFilter filter: FilterViewModel) -> [Post] {
        switch filter {
        case .posts: return posts
        case .upvotes: return upVotedPosts
        case .downvotes: return downVotedPosts
        }
    }
    
    func fetchUserPosts(){
        guard let uid = user.id else {return}
        service.fetchPosts(forUid: uid) { posts in
            self.posts = posts
            for i in 0 ..< posts.count {
                self.posts[i].user = self.user
            }
        }
    }
    func fetchUpvotedPosts() {
        guard let uid = user.id else { return }

        service.fetchUpVotedPosts(forUid: uid) { upVotedPosts in
            self.upVotedPosts = upVotedPosts

            for i in 0 ..< upVotedPosts.count {
                let uid = upVotedPosts[i].uid
                self.userService.fetchUser(withUid: uid) { user in
                    self.upVotedPosts[i].user = user
                }
            }
        }
    }
    func fetchDownvotedPosts() {
        guard let uid = user.id else { return }

        service.fetchDownVotedPosts(forUid: uid) { downVotedPosts in
            self.downVotedPosts = downVotedPosts

            for i in 0 ..< downVotedPosts.count {
                let uid = downVotedPosts[i].uid
                self.userService.fetchUser(withUid: uid) { user in
                    self.downVotedPosts[i].user = user
                }
            }
            
        }
    }
}
