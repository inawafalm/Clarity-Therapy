//
//  LoginPage.swift
//  Clarity Therapy
//
//  Created by Nawaf Almutairi on 23/05/2022.
//

import SwiftUI

struct SignInPage: View {
    
    @State var email : String = ""
    @State var password : String = ""
    
    var body: some View {
        VStack {
            Spacer()

            Text("Login")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(Color("text"))
            
            
            TextField("Email", text: $email)
            .textFieldStyle(RoundedBorderTextFieldStyle())

            TextField("Password", text: $email)
            .textFieldStyle(RoundedBorderTextFieldStyle())

            HStack{
                Spacer()
                Text("Reset your Password")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(Color("text"))
                    .underline()

            }
            
            Text("Login")
                .foregroundColor(.white)
                .fontWeight(.semibold)
                .frame(width: 300)
                .buttonStyle(buttonChoiceStyle(color: "Myblue"))
                .padding(.top,35)

            
            Spacer()
            
            HStack{
                Text("Don't have an account ?")
                Text("Signup")
                    .foregroundColor(Color("Myblue"))
                    .fontWeight(.semibold)
            } .font(.subheadline)
            
        }
        .padding()
    }
}

struct SignInPage_Previews: PreviewProvider {
    static var previews: some View {
        SignInPage()
    }
}
