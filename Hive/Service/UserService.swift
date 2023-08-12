//
//  UserService.swift
//  Hive
//
//  Created by justin casler on 6/8/23.
//


import Firebase
import FirebaseFirestoreSwift

struct UserService {
    func fetchUser(withUid uid: String, completion: @escaping(User) -> Void) {
        Firestore.firestore().collection("users")
            .document(uid)
            .getDocument{snapshot, _ in
                guard let snapshot = snapshot else {return}
                
                guard let user = try? snapshot.data(as: User.self) else {return}
                
                completion(user)
            }
    }
    
    func fetchUsers(completion: @escaping([User]) -> Void) {
        Firestore.firestore().collection("users")
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else {return}
                let user = documents.compactMap({try? $0.data(as: User.self)})
                completion(user)
                
            }
    }

}
