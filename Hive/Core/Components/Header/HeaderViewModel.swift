//
//  HeaderViewModel.swift
//  Hive
//
//  Created by justin casler on 5/26/23.
//

import SwiftUI


class HeaderViewModel: ObservableObject {
    @Published var startMinY: CGFloat = 0
    @Published var offset: CGFloat = 0
    
    @Published var headerOffset: CGFloat = 0
    @Published var topScrollOffset: CGFloat = 0
    @Published var bottomScrollOffset: CGFloat = 0
}

