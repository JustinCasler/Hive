//
//  ProfileColorSelectorView.swift
//  Hive
//
//  Created by justin casler on 7/2/23.
//

import SwiftUI

struct ProfileColorSelectorView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        let colors: [String] = [".red", ".blue", ".green", ".purple", ".brown", ".cyan", ".gray", ".indigo", ".mint", ".orange", ".pink", ".teal"]
        
        VStack{
            VStack(alignment: .leading) {
                HStack{Spacer()}
                Text("Get Started.")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                Text("Choose your profile color")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
            }
            .frame(height:260)
            .padding(.leading)
            .background(Color(.systemYellow))
            .foregroundColor(.white)
            .clipShape(RoundedShape(corners: [.bottomRight]))
            
            VStack {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    ForEach(colors, id: \.self) { (color: String) in
                        Button{
                            viewModel.selectColor(color)
                        } label: {
                            Circle()
                                .foregroundColor(Color(colorStringToSwiftUIColor(color) ?? .clear))
                                .frame(width: 50, height: 50)
                                .padding()
                        }
                    }
                }
            }
            .padding()
            Spacer()
        }
        .ignoresSafeArea()
    }
}

struct ProfileColorSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileColorSelectorView()
    }
}
