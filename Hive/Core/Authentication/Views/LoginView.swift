//
//  LoginView.swift
//  Hive
//
//  Created by justin casler on 6/5/23.
//

import SwiftUI
import UIKit

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack{
            VStack(alignment: .leading){
                HStack{Spacer()}
                Text("Hey!")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                Text("Welcome Back")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
            }
            .frame(height:260)
            .padding(.leading)
            .background(Color(.systemYellow))
            .foregroundColor(.white)
            .clipShape(RoundedShape(corners: [.bottomRight]))
            
            VStack(spacing: 40){
                CustomInputField(imageName: "envelope", placeholderText: "Email", text: $email)
                CustomInputField(imageName: "lock",               placeholderText: "Password",
                    isSecureField: true,
                    text: $password)
            }
            .padding(.horizontal, 32)
            .padding(.top, 44)
            
            HStack{
                Spacer()
                
                NavigationLink{
                    ForgotPasswordView()
                } label: {
                    Text("Forgot Password?")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(Color(.systemYellow))
                        .padding(.top)
                        .padding(.trailing, 24)
                }
            }
            
            Button {
                viewModel.login(withEmail: email, password: password)
            } label : {
                Text("Sign in")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width:340, height:50)
                    .background(Color(.systemYellow))
                    .clipShape(Capsule())
                    .padding()
            }
            .shadow(color: .gray.opacity(0.5), radius: 10, x:0, y:0)
            
            Spacer()
            NavigationLink {
                RegistrationView()
                    .navigationBarHidden(true)
            } label: {
                HStack{
                    Text("Don't have an account?")
                        .font(.footnote)
                    Text("Sign Up")
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
            }
            .padding(.bottom, 32)
            .navigationBarBackButtonHidden(true)
            .foregroundColor(Color(.systemBlue))
            
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }

    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
