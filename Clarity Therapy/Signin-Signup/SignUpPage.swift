//
//  SignUpPage.swift
//  Clarity Therapy
//
//  Created by Nawaf Almutairi on 30/05/2022.
//

import SwiftUI

struct SignUpPage: View {
    
    @State var email : String = ""
    @State var password : String = ""
    
    var body: some View {
        VStack {
            Spacer()

            Text("Sign-Up")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(Color("text"))
            
            
            TextField("Email", text: $email)
            .textFieldStyle(RoundedBorderTextFieldStyle())

            TextField("Password", text: $email)
            .textFieldStyle(RoundedBorderTextFieldStyle())

            
            Text("Sign-Up")
                .foregroundColor(.white)
                .fontWeight(.semibold)
                .frame(width: 300)
                .buttonStyle(buttonChoiceStyle(color: "Myblue"))
                .padding(.top,35)
            
            Spacer()
            
        }
        .padding()
    }
}


struct SignUpPage_Previews: PreviewProvider {
    static var previews: some View {
        SignUpPage()
    }
}
