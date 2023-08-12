//
//  HeaderView.swift
//  Hive
//
//  Created by justin casler on 4/26/23.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        VStack{
            HStack(){
                Text("Hive")
                    .font(Font.largeTitle.weight(.bold))
                
                Spacer()
            }
            .padding()
            .background(.white)
            .overlay(
                Divider(),alignment: .bottom
            )
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
