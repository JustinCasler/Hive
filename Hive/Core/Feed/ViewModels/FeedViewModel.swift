//
//  FeedViewModel.swift
//  Hive
//
//  Created by justin casler on 6/21/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class FeedViewModel: ObservableObject {
    var service = PostService()
    let userService = UserService()
    var uid: String?
    
    @Published var user: User?
    @Published var posts = [Post]()
    @Published var category = "General"
    @Published var fetchCategory = false
    
    init() {
        self.uid = Auth.auth().currentUser?.uid ?? "nil"
        fetchUser()
    }
    
    private func fetchUser() {
        userService.fetchUser(withUid: uid ?? "" ) { fetchedUser in
            DispatchQueue.main.async {
                self.user = fetchedUser
            }
        }
    }
    
    func fetchPosts(forCategory category: String) {
        service.fetchPosts(forCategory: category) { posts in
            self.posts = posts
            for i in 0 ..< posts.count {
                let uid = posts[i].uid
                self.userService.fetchUser(withUid: uid) { user in
                    self.posts[i].user = user
                }
            }
        }
    }
}







