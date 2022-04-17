//
//  ConfirmAppointmentView.swift
//  Clarity Therapy
//
//  Created by Nawaf Almutairi on 25/03/2022.
//

import Foundation
import SwiftUI
import CryptoKit


struct ConfirmationStruct : Identifiable {
    
    var id = UUID()
    var clinicName : String
    var clientPrivateKeyString: String
    var therapistPublicKey: P256.KeyAgreement.PublicKey
    
}


struct ConfirmAppointmentView: View {
  
    @Binding var isPresented: Bool
//    @State var nextView = false

    let confirmView : ConfirmationStruct
    @EnvironmentObject var appointment : Appointments
    @EnvironmentObject var awsData : AWSData
    
   // @ObservedObject var myUser = Clients()

    
    let columns = [
            GridItem(.adaptive(minimum: 80)),
            GridItem(.adaptive(minimum: 80)),
            GridItem(.adaptive(minimum: 80))
        ]

    var body: some View {
        

        VStack(spacing:10) {
            HStack {
                Text("Appointment Type:")
                .font(.title3)
                .bold()
                .foregroundColor(Color("text"))
                Spacer()
            }
           // .padding(.horizontal)
                            
                //Remotely
                HStack {
                    
                    Button {
                        
                    } label: {
                        Text("Remote")
                            .bold()
                            .frame(width: 85,height: 15)
                            .foregroundColor(.white)
                            .buttonStyle(buttonChoiceStyle())
                        
                    }
                    
                    Button {
                        
                    } label: {
                        Text("Remote")
                            .bold()
                            .frame(width: 85,height: 15)
                            .foregroundColor(.white)
                            .buttonStyle(buttonChoiceStyle())
                        
                    }
                    
                }
            
            HStack {
                
                Text("Selected Date: ")
                    .font(.title3)
                    .bold()
                    .foregroundColor(Color("text"))
                Spacer()
                Image(systemName: "calendar")
                    .foregroundColor(Color(hex: 0x646464))
                Text("Edit")
                    .foregroundColor(Color(hex: 0x646464))
                    .offset(x:-5)
                
            }
            .padding(.top,20)
            
            HStack {
                Text("3/22/2021")
                    .bold()
                    .frame(width: 100,height: 10)
                    .foregroundColor(.white)
                .buttonStyle(buttonChoiceStyle())
                Spacer()
            }
                
            
            HStack {
                
                Text("Selected Time: ")
                    .font(.title3)
                    .bold()
                    .foregroundColor(Color("text"))
                Spacer()
                
            }.padding(.top,10)
            
            HStack {
                
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(1...8, id: \.self) { item in
                        withAnimation {
                            Text("11:11 PM")
                                .bold()
                                .frame(width: 75,height: 15)
                                .foregroundColor(.white)
                            .buttonStyle(buttonChoiceStyle())
                        }
                      
                        
                    }
                }
                
                
                Spacer()
            }
            
                Spacer()
            
            
            Button {
                
                let clientPrivateKey = try! importPrivateKey(confirmView.clientPrivateKeyString)
                let deriveSymmetricKey = try! deriveSymmetricKey(privateKey: clientPrivateKey, publicKey: confirmView.therapistPublicKey)
                let messageEncrypted = try! encrypt(text: "Hiiiiiii", symmetricKey: deriveSymmetricKey)
                appointment.appointmentArray.append(AppointmentStruct(messageEncrypted: messageEncrypted, therapistPublicKey: confirmView.therapistPublicKey, clientPublicKey: clientPrivateKey.publicKey))
                
            } label: {
                Text("Confirm")
                    .frame(width: 250)
                    .foregroundColor(.white)
                    .buttonStyle(buttonChoiceStyle())
                
            }

            Button {

                self.isPresented = false
                //self.nextView = true

            } label: {
                Text("Dismiss")
                    .frame(width: 250)
                    .foregroundColor(.white)
                    .buttonStyle(buttonChoiceStyle())

            }
            
            Spacer()
                
//                .background(EmptyView().sheet(isPresented: $nextView, onDismiss: {
//                    self.nextView = false
//                }, content: {
//                    TherapistView(isPresented: $nextView)
//                }))
            
            
        }.padding()

        
    }

}


 
 
extension ConfirmAppointmentView {

}
    


//struct ConfirmAppointmentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ConfirmAppointmentView()
//    }
//}
