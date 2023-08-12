//
//  UploadPostViewModel.swift
//  Hive
//
//  Created by justin casler on 6/21/23.
//

import Foundation

class UploadPostViewModel: ObservableObject {
    @Published var didUploadPost = false
    @Published var feedDidUploadPost = false
    let service = PostService()
    
    func uploadPost(withTitle title: String, withCaption caption: String, withCategory category: String) {
        service.uploadPost(title: title, caption: caption, category: category) { success in
            if success {
                self.didUploadPost = true
                self.feedDidUploadPost = true
            } else {
                print("DEBUG: upload post failed")
            }
            
        }
    }
}
