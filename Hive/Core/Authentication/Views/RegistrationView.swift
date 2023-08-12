//
//  RegistrationView.swift
//  Hive
//
//  Created by justin casler on 6/5/23.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var username = ""
    @State private var fullname = ""
    @State private var password = ""
    @Environment (\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack{
            
            VStack(alignment: .leading){
                HStack{Spacer()}
                Text("Get Started.")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                Text("Create your account")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
            }
            .frame(height:260)
            .padding(.leading)
            .background(Color(.systemYellow))
            .foregroundColor(.white)
            .clipShape(RoundedShape(corners: [.bottomRight]))
            
            VStack(spacing: 40){
                CustomInputField(imageName: "envelope",
                                 placeholderText: "Email",
                                 text: $email)
                CustomInputField(imageName: "person",
                                 placeholderText: "Username",
                                 text: $username)
                CustomInputField(imageName: "person",
                                 placeholderText: "Full name",
                                 text: $fullname)
                CustomInputField(imageName: "lock",               placeholderText: "Password",
                                 isSecureField: true,
                                 text: $password)
            }
            .padding(32)
            
            Button {
                viewModel.register(withEmail: email, password: password, fullname: fullname, username: username)
            } label : {
                Text("Sign up")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width:340, height:50)
                    .background(Color(.systemYellow))
                    .clipShape(Capsule())
                    .padding()
            }
            .shadow(color: .gray.opacity(0.5), radius: 10, x:0, y:0)
            Spacer()
            
            Button{
                presentationMode.wrappedValue.dismiss()
            } label: {
                HStack{
                    Text("Already have an account?")
                        .font(.footnote)
                    Text("Sign In")
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
            }
            .navigationBarBackButtonHidden(true)
            .padding(.bottom, 32)
            .foregroundColor(Color(.systemBlue))
        }
        .ignoresSafeArea()
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        .sheet(isPresented: $viewModel.didAuthenticateUser) {
            ProfileColorSelectorView()
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
