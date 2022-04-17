//
//  DetailView.swift
//  Clarity Therapy
//
//  Created by Nawaf Almutairi on 25/03/2022.
//

import Foundation
import SwiftUI
import CryptoKit


struct DetailStruct : Identifiable {
    
    var id = UUID()
    var clinicName : String
    var image : String
    var type: String
    var price: String
    var remotely: Bool?
    var inperson: Bool?
    var experience: String
    var qualifactions: String
    var language: String
    var Description: String
    var clientPrivateKey: P256.KeyAgreement.PrivateKey
    var therapistPublicKey: P256.KeyAgreement.PublicKey
    
}


struct DetailView: View {
    

    //let detailViewItems: DetailStruct
    
    //@Binding var isPresented: Bool
    @State var isPresentingConfirmation = false
    @State var clientPrivateKeyString : String
    @State var therapistPublicKey : P256.KeyAgreement.PublicKey

    @EnvironmentObject var appointment : Appointments
    @EnvironmentObject var awsData : AWSData
    
    
    @State var encyptedMessage = Data()



    var body: some View {
        
        VStack{
            VStack {
                HStack {
//                    Image(detailViewItems.image)
//                            .resizable()
//                            .clipShape(Circle())
//                            .shadow(radius: 10)
//                            .frame(width: 100, height: 100)
//                        .padding(5)
                        
                        VStack(alignment:.leading){
                            Text("detailViewItems.clinicName")
                                .font(.title3)
                                .foregroundColor(Color("text"))
                            Text("detailViewItems.type")
                                .font(.footnote)
                                .fontWeight(.light)
                            
                        }
                        .padding(.top,15)
                        Spacer()
                    
                    }
                .padding()
                
                Divider()
                    .padding(.horizontal)
                
                VStack(spacing:5){
                    
    //                HStack{
    //
    //                    Image(systemName: "heart.text.square.fill")
    //                        .font(.title2)
    //                        .foregroundColor(Color("Myblue"))
    //
    //                    Text("Type:")
    //                        .foregroundColor(Color(type))
    //                        .bold()
    //
    //                    Text("Psycological")
    //                    Spacer()
    //                }.padding(.horizontal)
                    
                    
                    HStack{
                        
                        Image(systemName: "heart.text.square.fill")
                            .font(.title2)
                            .foregroundColor(Color("Myblue"))
                        
                        Text("Price:")
                            .foregroundColor(Color("text"))
                            .bold()
                        
                        Text("detailViewItems.price")
                        Spacer()
                    }.padding(.horizontal)
                    
                    
                    HStack{
                        
                        Image(systemName: "heart.text.square.fill")
                            .font(.title2)
                            .foregroundColor(Color("Myblue"))
                        
                        Text("Method:")
                            .foregroundColor(Color("text"))
                            .bold()
//                        HStack {
//                            if detailViewItems.inperson ?? false {
//                        Text("In-Person")
//                            }
//                            if detailViewItems.remotely ?? false {
//                                Text("Remotely")
//                            }
//                        }
                        Spacer()
                    }.padding(.horizontal)
                }
                .padding(.top)
                
                VStack(spacing:15){
                    
                    HStack{
                        
                        Text("Experience:")
                            .bold()
                        Spacer()
                        Text("detailViewItems.experience")
                        
                    }.padding(.horizontal)
                    
                    
                    HStack{
                        
                        Text("Qualifactions:")
                            .bold()
                        Spacer()
                        Text("detailViewItems.qualifactions")
                        
                    }.padding(.horizontal)
                    
                    
                    HStack{
                        
                        Text("Language")
                            .bold()
                        Spacer()
                        Text("detailViewItems.language")
                        
                    }.padding(.horizontal)
                    
                    VStack{
                        
                        HStack {
                            Text("Description")
                                .bold()
                            Spacer()

                        }
                        HStack {
                            Text("detailViewItems.Description")
                            Spacer()
                        }
                        .padding()
                        
                    }.padding(.horizontal)
                }
                .background(Color(hex: 0xF8F8F8))
                .padding(.top)
                
                Spacer()
                
                Button {
                    
                } label: {
                    Text("Book a Session")
                        .frame(width: 250)
                        .foregroundColor(.white)
                        .buttonStyle(buttonChoiceStyle())
                        .onTapGesture {
                            self.isPresentingConfirmation.toggle()
                            
                            
                        }
                    
                }.background(
                    NavigationLink(destination: ConfirmAppointmentView(isPresented: $isPresentingConfirmation, confirmView: ConfirmationStruct(clinicName: "", clientPrivateKeyString: clientPrivateKeyString, therapistPublicKey: therapistPublicKey)), isActive: $isPresentingConfirmation) {}
                )
                
                Spacer()
                
            }
            
            Text("Encrypt")
                .onTapGesture {
                    
                    let clientPrivateKey = try! importPrivateKey(clientPrivateKeyString)
                    let deriveSymmetricKey = try! deriveSymmetricKey(privateKey: clientPrivateKey, publicKey: therapistPublicKey)
                    let messageEncrypted = try! encrypt(text: "Hiiiiiii", symmetricKey: deriveSymmetricKey)
                    appointment.appointmentArray.append(AppointmentStruct(messageEncrypted: messageEncrypted, therapistPublicKey: therapistPublicKey, clientPublicKey: clientPrivateKey.publicKey))
     
                }
            
            Text("Check")
                .onTapGesture {
            
                }
            
        }
.navigationBarTitleDisplayMode(.inline)
        
        

        
    }
    
    
    
}




extension DetailView {

    
    /*
    private func encryptionFunc(therapistPublicKey: Any) {
        
        

        let protocolSalt = "Hello, playground".data(using: .utf8)!
        let message = "Sealed box OPENED!!!"


        let therapistPublicKey = therapistPublicKey

        let sSharedSecret = try! detailViewItems.clientPrivateKey.sharedSecretFromKeyAgreement(with: therapistPublicKey as! P256.KeyAgreement.PublicKey)
        let sSymmetricKey = sSharedSecret.hkdfDerivedSymmetricKey(using: SHA256.self,
                                                              salt: protocolSalt,
                                                              sharedInfo: Data(),
                                                              outputByteCount: 32)

    let nameSensitive = message.data(using: .utf8)!

    let encryptedData = try! ChaChaPoly.seal(nameSensitive, using: sSymmetricKey).combined
//
//    print("EncryptedData: ")
//    print(encryptedData)
//
//
//        print("\n")
//        print("\n")
//        print("\n")
//        print("--Before Adding to Array--")
//        print("Client Public Key")
//        print(detailViewItems.clientPrivateKey.publicKey)
//        print("therapistPublicKey Public Key")
//        print(detailViewItems.therapistPublicKey)therapistPublicKey
//        appointment.appointmentArray.append(AppointmentStruct(messageEncrypted: encryptedData, therapistPublicKey: therapistPublicKey as! P256.KeyAgreement.PublicKey, clientPublicKey: detailViewItems.clientPrivateKey.publicKey))
//        print("----------ADDED----------")
//        print("\n")
//        print("\n")
//        print("\n")

}
   */
    
    func importPrivateKey(_ privateKey: String) throws -> P256.KeyAgreement.PrivateKey {
        let privateKeyBase64 = privateKey.removingPercentEncoding!
        let rawPrivateKey = Data(base64Encoded: privateKeyBase64)!
        return try P256.KeyAgreement.PrivateKey(rawRepresentation: rawPrivateKey)
    }
    
    func deriveSymmetricKey(privateKey: P256.KeyAgreement.PrivateKey, publicKey: P256.KeyAgreement.PublicKey) throws -> SymmetricKey {

        let sharedSecret = try privateKey.sharedSecretFromKeyAgreement(with: publicKey)
        let symmetricKey = sharedSecret.hkdfDerivedSymmetricKey(
            using: SHA256.self,
            salt: "My Key Agreement Salt".data(using: .utf8)!,
            sharedInfo: Data(),
            outputByteCount: 32
        )
        return symmetricKey
    }
    func encrypt(text: String, symmetricKey: SymmetricKey) throws -> String {
        let textData = text.data(using: .utf8)!
        let encrypted = try AES.GCM.seal(textData, using: symmetricKey)
        return encrypted.combined!.base64EncodedString()
    }

}


extension Color {
    init(hex: Int, opacity: Double = 1.0) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}
