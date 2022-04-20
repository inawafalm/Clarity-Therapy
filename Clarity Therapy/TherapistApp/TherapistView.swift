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
    @EnvironmentObject var therapistApp : TherapistApp
    //
    @State var encyptedMessage = Data()

    
    
    var body: some View {

        
        NavigationView {
                ScrollView(.vertical) {
                    
                    ForEach(appointment.appointmentArray) { appt in
                        
                        NavigationLink(destination: Text("Hi")) {
                            let therapistPrivateKey = try! importPrivateKey(therapistApp.myUserTherapist[0].privateKey)
                            let deriveSymmetricKey = try! deriveSymmetricKey(privateKey:therapistPrivateKey , publicKey: appt.clientPublicKey)
                            let decryption = try! decrypt(input: appt.messagesEncrypted, symmetricKey: deriveSymmetricKey)
                            
                            ClientCardView(name: decryption.clientName, phone: decryption.clientPhone, type: decryption.appointmentType, time: decryption.time, date: decryption.date
                            )
                                .padding(10)
                        }
                        
                     
                    }
                   
                   
                     
                }.listStyle(GroupedListStyle())
                .navigationTitle("Appointments")
        }
    }
    
}




struct TherapistView_Previews: PreviewProvider {
    static var previews: some View {
        TherapistView(isPresented: .constant(true))
            .environmentObject(Appointments())
    }
}

