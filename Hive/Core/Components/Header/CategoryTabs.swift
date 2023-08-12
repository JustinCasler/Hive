//
//  CategoryTabs.swift
//  Hive
//
//  Created by justin casler on 6/1/23.
//

import SwiftUI

struct CategoryTabs: View {
    @ObservedObject var feedViewModel: FeedViewModel
    let service = UserService()
    var topic: String
    var body: some View {
        Button {
            feedViewModel.fetchCategory = true
            feedViewModel.category = topic
        } label: {
            Text(topic)
                .bold()
                .font(.system(size: 14))
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(feedViewModel.category == topic ? Color(.systemYellow) : Color(.systemGray2))
                .foregroundColor(.white)
                .clipShape(Capsule())
        }
    }
}


