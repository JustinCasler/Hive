//
//  PostService.swift
//  Hive
//
//  Created by justin casler on 6/21/23.
//

import Firebase
import FirebaseFirestoreSwift

struct PostService {
    func uploadPost(title: String, caption: String, category: String, completion: @escaping(Bool) -> Void){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let data = ["uid": uid,
                    "title": title,
                    "caption": caption,
                    "category": category,
                    "upvote" : 0,
                    "downvote" : 0,
                    "timestamp": Timestamp(date: Date())] as [String: Any]
        Firestore.firestore().collection("posts").document()
            .setData(data) { error in
                if let error = error {
                    print("DEBUG: Failed to uoload tweet with error: \(error.localizedDescription)")
                    completion(false)
                    return
                }
                completion(true)
            }
    }
    func fetchPosts(completion: @escaping([Post]) -> Void) {
        Firestore.firestore().collection("posts")
            .order(by: "timestamp", descending: true)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else {return}
                let posts = documents.compactMap({ try? $0.data(as: Post.self) })
                completion(posts)
            }
    }
    func fetchPosts(forCategory category: String, completion: @escaping([Post]) -> Void){
        if category == "General" {
            Firestore.firestore().collection("posts")
                .order(by: "timestamp", descending: true)
                .getDocuments { snapshot, _ in
                    guard let documents = snapshot?.documents else {return}
                    let posts = documents.compactMap({ try? $0.data(as: Post.self) })
                    completion(posts)
                }
        } else {
            Firestore.firestore().collection("posts")
                .whereField("category", isEqualTo: category)
                .getDocuments { snapshot, _ in
                    guard let documents = snapshot?.documents else {return}
                    let posts = documents.compactMap({ try? $0.data(as: Post.self) })
                    completion(posts.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue()} ))
                }
        }
    }
    func fetchPosts(forUid uid: String, completion: @escaping([Post]) -> Void) {
        Firestore.firestore().collection("posts")
            .whereField("uid", isEqualTo: uid)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else {return}
                let posts = documents.compactMap({ try? $0.data(as: Post.self) })
                completion(posts.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue()} ))
            }
    }
    
    func upvote(_ post: Post, completion: @escaping() -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let postId = post.id else {return}
        
        let userUpvotesRef = Firestore.firestore().collection("users").document(uid).collection("user-upVotes")
        
        Firestore.firestore().collection("posts").document(postId)
            .updateData(["upvote" : FieldValue.increment(Int64(1))]) { _ in
                userUpvotesRef.document(postId).setData([:]) { _ in
                    completion()
                }
            }
    }
    func unUpvote (_ post: Post, completion: @escaping() -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let postId = post.id else {return}
        print("post.upvote: ", post.upvote)
        if post.upvote <= 0 {
            completion()
        }
        
        let userUpvotesRef = Firestore.firestore().collection("users").document(uid).collection("user-upVotes")
        
        Firestore.firestore().collection("posts").document(postId)
            .updateData(["upvote": FieldValue.increment(Int64(-1))]) { _ in
                userUpvotesRef.document(postId).delete { _ in
                    completion()
                }
            }
        
    }
    func downvote(_ post: Post, completion: @escaping() -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let postId = post.id else {return}
        
        let userDownvotesRef = Firestore.firestore().collection("users").document(uid).collection("user-downVotes")
        
        Firestore.firestore().collection("posts").document(postId)
            .updateData(["downvote": FieldValue.increment(Int64(1))]) { _ in
                userDownvotesRef.document(postId).setData([:]) { _ in
                    completion()
                }
            }
    }
    
    func unDownvote (_ post: Post, completion: @escaping() -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let postId = post.id else {return}
        if post.downvote <= 0 {
            completion()
        }
        
        let userDownvotesRef = Firestore.firestore().collection("users").document(uid).collection("user-downVotes")
        
        Firestore.firestore().collection("posts").document(postId)
            .updateData(["downvote": FieldValue.increment(Int64(-1))]) { _ in
                userDownvotesRef.document(postId).delete { _ in
                    completion()
                }
            }
        
    }
    
    func checkIfUserUpvote(_ post: Post, completion: @escaping(Bool) -> Void ) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let postId = post.id else {return}
        Firestore.firestore().collection("users")
            .document(uid)
            .collection("user-upVotes")
            .document(postId).getDocument { snapshot, _ in
                guard let snapshot = snapshot else {return}
                completion(snapshot.exists)
            }
    }
    func checkIfUserDownvote(_ post: Post, completion: @escaping(Bool) -> Void ) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let postId = post.id else {return}
        Firestore.firestore().collection("users")
            .document(uid)
            .collection("user-downVotes")
            .document(postId).getDocument { snapshot, _ in
                guard let snapshot = snapshot else {return}
                completion(snapshot.exists)
            }
    }
    
    func fetchUpVotedPosts(forUid uid: String, completion: @escaping([Post]) -> Void){
        var posts = [Post]()
        Firestore.firestore().collection("users")
            .document(uid)
            .collection("user-upVotes")
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                documents.forEach { doc in
                    let postID = doc.documentID
                    
                    Firestore.firestore().collection("posts")
                        .document(postID)
                        .getDocument { snapshot, _ in
                            guard let post = try? snapshot?.data(as: Post.self) else { return }
                            posts.append(post)
                            completion(posts)
                        }
                }
            }
    }
    func fetchDownVotedPosts(forUid uid: String, completion: @escaping([Post]) -> Void){
        var posts = [Post]()
        Firestore.firestore().collection("users")
            .document(uid)
            .collection("user-downVotes")
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                documents.forEach { doc in
                    let postID = doc.documentID
                    
                    Firestore.firestore().collection("posts")
                        .document(postID)
                        .getDocument { snapshot, _ in
                            guard let post = try? snapshot?.data(as: Post.self) else { return }
                            posts.append(post)
                            completion(posts)
                        }
                }
            }
    }
}
