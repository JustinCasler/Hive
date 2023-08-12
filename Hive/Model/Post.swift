//
//  Post.swift
//  Hive
//
//  Created by justin casler on 6/22/23.
//
import Firebase
import FirebaseFirestoreSwift

struct Post: Identifiable, Decodable {
    @DocumentID var id: String?
    let title: String
    let caption: String
    let timestamp: Timestamp
    let category: String
    let uid: String
    var upvote: Int
    var downvote: Int
    
    var user: User?
    var didUpvote: Bool? = false
    var didDownvote: Bool? = false
}
