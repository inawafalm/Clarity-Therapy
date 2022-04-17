//
//  File.swift
//  Clarity Therapy
//
//  Created by Nawaf Almutairi on 03/04/2022.
//

import Foundation
import SwiftUI
import CryptoKit


struct TherapistView:View {
    
   
    @Binding var isPresented: Bool
    @EnvironmentObject var appointment : Appointments
    @EnvironmentObject var awsData : AWSData
    @EnvironmentObject var therapistApp : TherapistApp
    @EnvironmentObject var myUserClient : MyUserClient
    //
    @State var encyptedMessage = Data()

    
    
    var body: some View {

        
        VStack {
            Text("Hi")
       
            VStack {
                
                Button {

        
              } label: {
                  Text("Check array Clinics")
                      .frame(width: 250)
                      .foregroundColor(.white)
                      .buttonStyle(buttonChoiceStyle())
        
              }
                
                Button {
                    let therapistPrivateKey = try! importPrivateKey(therapistApp.myUserTherapist[0].privateKey)
                    let deriveSymmetricKey = try! deriveSymmetricKey(privateKey:therapistPrivateKey , publicKey: appointment.appointmentArray[0].clientPublicKey)
                    let text = decrypt(text: appointment.appointmentArray[0].messageEncrypted, symmetricKey: deriveSymmetricKey)
                    print(text)
              } label: {
                  Text("Decrypt")
                      .frame(width: 250)
                      .foregroundColor(.white)
                      .buttonStyle(buttonChoiceStyle())
        
              }
                
            }
                

        }

        
    }
    
    
}




//struct TherapistView_Previews: PreviewProvider {
//    static var previews: some View {
//        TherapistView()
//    }
//}

