//
//  AuthViewModel.swift
//  Hive
//
//  Created by justin casler on 6/6/23.
//

import SwiftUI
import Firebase

class AuthViewModel: ObservableObject{
    @Published var userSession: FirebaseAuth.User?
    @Published var didAuthenticateUser = false
    @Published var currentUser: User?
    private var postService  = PostService()
    private var tempUserSession: FirebaseAuth.User?
    private let service = UserService()
    
    init(){
        self.userSession = Auth.auth().currentUser
        self.fetchUser()
    }
    
    func login(withEmail email : String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to sign in with error \(error.localizedDescription)")
                return
            }
            guard let user = result?.user else {return}
            self.userSession = user
            self.fetchUser()
        }

    }
    
    func register(withEmail email: String, password: String, fullname: String, username: String){
        Auth.auth().createUser(withEmail: email, password: password){ result,error in
            if let error = error {
                print("Debug: Failed to register with error \(error.localizedDescription)")
                return
            }
            guard let user = result?.user else {return}

            self.tempUserSession = user
            print ("DEBUG: USER IS \(String(describing: self.userSession))")
            
            let data = ["email" : email,
                        "username": username.lowercased(),
                        "fullname": fullname,
                        "uid": user.uid,
                        ]
            Firestore.firestore().collection("users")
                .document(user.uid)
                .setData(data){ _ in
                    self.didAuthenticateUser = true
                }
        }
    }
    
    func forgotPassword(withEmail email: String){
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            // Your code here
        }
    }

    func signOut() {
        userSession = nil
        try?Auth.auth().signOut()
    }
    
    func fetchUser() {
        guard let uid = self.userSession?.uid else {return}
        
        service.fetchUser(withUid: uid) { user in
            self.currentUser = user
        }
    }
    
    func selectColor(_ color: String) {
        guard let uid = tempUserSession?.uid else {return}
        Firestore.firestore().collection("users")
            .document(uid)
            .updateData(["color": color]) { _ in
                self.userSession = self.tempUserSession
                self.fetchUser()
                self.didAuthenticateUser = false
            }
    }
}
