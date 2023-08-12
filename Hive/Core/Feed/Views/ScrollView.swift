//
//  ScrollView.swift
//  Hive
//
//  Created by justin casler on 4/20/23.
//

import SwiftUI

struct ScrollView: View {
    var body: some View {
        ScrollView {
            LazyVStack{
                ForEach(0 ... 20, id: \.self) { _ in
                    PostView()
                        .padding()
                }
            }
        }
    }
}

struct ScrollView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView()
    }
}
