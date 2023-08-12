//
//  FilterViewModel.swift
//  social_media
//
//  Created by justin casler on 4/15/23.
//

import Foundation

enum FilterViewModel: Int, CaseIterable{
    case posts
    case upvotes
    case downvotes
    var title: String{
        switch self{
        case .posts: return "Posts"
        case .upvotes: return "Upvotes"
        case .downvotes: return "Downvotes"
        }
    }
}
