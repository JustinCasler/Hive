//
//  User.swift
//  Hive
//
//  Created by justin casler on 6/8/23.
//
import FirebaseFirestoreSwift
import Firebase

struct User: Identifiable, Decodable {
    @DocumentID var id: String?
    let username: String
    let fullname: String
    let email: String
    var color: String
    
    var category: String? = "General"
    var isCurrentUser: Bool { return Auth.auth().currentUser?.uid == id }
}
