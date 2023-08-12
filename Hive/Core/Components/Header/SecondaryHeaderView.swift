//
//  SecondaryHeaderView.swift
//  Hive
//
//  Created by justin casler on 5/25/23.
//

import SwiftUI

struct SecondaryHeaderView: View {
    @ObservedObject var feedViewModel: FeedViewModel
    let categories = ["General", "Romance", "Frenemies", "Beef", "Unpopular Opinons", "Big Decision"]
    
    var body: some View {
        HStack {
            ScrollView(.horizontal, showsIndicators: false ){
                HStack {
                    ForEach(categories, id: \.self) { category in
                        CategoryTabs(feedViewModel: feedViewModel, topic: category)
                    }
                }
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .background(.ultraThinMaterial)
    }
}

