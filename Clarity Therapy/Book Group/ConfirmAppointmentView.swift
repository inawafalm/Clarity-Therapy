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
    var clientName: String
    var clientPhone : String
    var clientPrivateKeyString: String
    var therapistName: String
    var therapistPublicKey: P256.KeyAgreement.PublicKey
    
    
}

struct EncryptionStruct : Identifiable {
    
    var id = UUID()
    var clientName: String
    var clientPhone : String
    var appointmentType: String
    var time: String
    var date: String
    
}

enum AppointmentType: String {
    case Remotely = "Remotely"
    case Inperson = "In person"
}




struct ConfirmAppointmentView: View {
  
//    @State var nextView = false
    @Binding var isPresented: Bool
    @State var appointmentType = AppointmentType.Inperson.rawValue
    @EnvironmentObject var appointment : Appointments
    @EnvironmentObject var awsData : AWSData
    
    @State var selectedDate = ""
    @State var selectedTime = ""
    
    let confirmView : ConfirmationStruct
    
    
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
                        appointmentType = AppointmentType.Inperson.rawValue
                    } label: {
                        Text("In-Person")
                            .bold()
                            .frame(width: 85,height: 15)
                            .foregroundColor(.white)
                            .buttonStyle(appointmentType == AppointmentType.Inperson.rawValue ? buttonChoiceStyle(color: "Myblue") : buttonChoiceStyle(color: "shadow"))
                        
                    }
                    
                    Button {
                        appointmentType = AppointmentType.Remotely.rawValue
                    } label: {
                        Text("Remote")
                            .bold()
                            .frame(width: 85,height: 15)
                            .foregroundColor(.white)
                            .buttonStyle(appointmentType == AppointmentType.Remotely.rawValue ? buttonChoiceStyle(color: "Myblue") : buttonChoiceStyle(color: "shadow"))

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
                .buttonStyle(buttonChoiceStyle(color: "Myblue"))
                .onTapGesture {
                    self.selectedDate = "3/22/2021"
                }
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
                            .buttonStyle(buttonChoiceStyle(color: "Myblue"))
                            
                            .onTapGesture {
                                self.selectedTime = item.description
                            }
                        }
                      
                        
                    }
                }
                
                
                Spacer()
            }
            
                Spacer()
            
            
            Button {
                
                let clientPrivateKey = try! importPrivateKey(confirmView.clientPrivateKeyString)
                let deriveSymmetricKey = try! deriveSymmetricKey(privateKey: clientPrivateKey, publicKey: confirmView.therapistPublicKey)
                
                let encrypted = EncryptionStruct(clientName: confirmView.clientName, clientPhone: confirmView.clientPhone, appointmentType: appointmentType, time: selectedTime, date: selectedDate)
                                
                let messageEncrypted = try! encrypt(input: encrypted, symmetricKey: deriveSymmetricKey)
                
                appointment.appointmentArray.append(AppointmentStruct(messagesEncrypted: messageEncrypted, therapistPublicKey: confirmView.therapistPublicKey, clientPublicKey: clientPrivateKey.publicKey))
                
            } label: {
                Text("Confirm")
                    .frame(width: 250)
                    .foregroundColor(.white)
                    .buttonStyle(buttonChoiceStyle(color: "Myblue"))
                
            }

            Button {

                self.isPresented = false
                //self.nextView = true

            } label: {
                Text("Dismiss")
                    .frame(width: 250)
                    .foregroundColor(.white)
                    .buttonStyle(buttonChoiceStyle(color: "Myblue"))

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
//        ConfirmAppointmentView(isPresented: .constant(true), confirmView: ConfirmationStruct(clinicName: "", clientPrivateKeyString: "", therapistPublicKey: generatePrivateKey().publicKey))
//    }
//}
