//
//  DetailClinicView.swift
//  Clarity Therapy
//
//  Created by Nawaf Almutairi on 18/02/2022.
//

import Foundation
import SwiftUI
import CryptoKit


struct DetailClinicView: View {
    
    @State var selectedThought: TherapistModel? = nil
    @State var isPresentingClinic = false
    @State var selectedDate = Date()
    @State var holdingDate = Date()
    @State var flag = false
    
    @State var clinicName : String
    @State var clinicPublicKey: Curve25519.KeyAgreement.PublicKey
    @State var clinicPrivateKey: Curve25519.KeyAgreement.PrivateKey
    @State var encyptedMessage = Data()
    @State var clientPublicKey: Any?
    
    //@ObservedObject var encryptionCaller = encryption(clinicPrivateKey: cu, clinicPublicKey: nil)
    
    
    // NEW
//    @ObservedObject var clientInfo = NetworkFirebase()
    

    
    static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()

    var body: some View {
        
        NavigationView {
            VStack {
                VStack {
                    Image("Kati")
                        .resizable()
                                .clipShape(Circle())
                                .shadow(radius: 10)
                            .frame(width: 175, height: 175)
                    Text(clinicName)
                    Text("Licensed Marriage and Family Therapist")
                }
                //Spacer()
                VStack {
                    HStack {
                        Image(systemName:"calendar")
                            .font(.title3)
                            .foregroundColor(Color("Myblue"))
                        Text(DetailClinicView.formatter.string(from: selectedDate))
                            .font(.system(size: 17))
                            .foregroundColor(Color("Myblue"))
                            .underline()
                            .onTapGesture{
                                
                                self.flag.toggle()
                                print("ON")
                            }
                    }
                    .padding(2)
                }
                
                HStack {
                    
                    ForEach(1 ..< 5) {_ in
                        Text("12:00")
                            .frame(width: 60, height: 25, alignment: .center)
                             .background(Color("Myblue"))
                             .clipShape(RoundedRectangle(cornerRadius: 5))
                    }
                }
                
                Button(action: {
                
                }, label: {
                    Text("Next")
                        .foregroundColor(.white)
                        .buttonStyle(buttonChoiceStyle())
                    .shadow(radius: 3)
                })
                    .padding()
                
                Spacer()
                
                HStack {
                    Text("Send")
                        .foregroundColor(.white)
                        .buttonStyle(buttonChoiceStyle())
                        .shadow(radius: 3)
                        .onTapGesture {
                            print("Heloooo!")
                    }
                }

            }
            .padding(.top)
            .navigationTitle("Choose Time")
        }
        .onAppear() {
            
        }
        
        if flag {
            Color.gray.opacity(0.4).edgesIgnoringSafeArea(.all)
                .scaleEffect()
                .onTapGesture {
                    self.flag.toggle()
                }
            VStack {
                HStack {
                    Button(action: {
                        self.flag.toggle()
                    }) {
                        Text("Cancel")
                            .font(.system(size: 17))
                            .foregroundColor(Color.white)
                        
                    }
                    .padding()
                    .padding(.horizontal,5)
                    Spacer()
                    Button(action: {
                        self.flag.toggle()
                        self.selectedDate = self.holdingDate
                    }) {
                        Text("Done")
                            .font(.system(size: 17))
                            .foregroundColor(Color.white)
                            .bold()
                    }
                    .padding()
                    .padding(.horizontal,5)
                    
                }.background(Color("Myblue"))
                
                DatePicker("", selection: $holdingDate)
                    .datePickerStyle(WheelDatePickerStyle())
                    .labelsHidden()
                Spacer()
                
                
            }
            
            .frame(width:UIScreen.main.bounds.width,height: 300)
            .background(Color.primary.colorInvert()).cornerRadius(50)
            .transition(.move(edge: .bottom))
            .animation(Animation.spring(response: 0.4, dampingFraction: 1.0, blendDuration: 1.0))
            .zIndex(0)
        }
        
    }
    
    
}


//struct DetailClinicView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailClinicView(clinicName: "Hi")
//    }
//}
/*
extension DetailClinicView {

    func encryptionFunc(clinicPublicKey: Any) -> (Any,Any) {
    
    let protocolSalt = "Hello, playground".data(using: .utf8)!

    
    let sPrivateKey = clientInfo.clientInfo1[0].clientPrivateKey
    let sPublicKey = clientInfo.clientInfo1[0].clientPublicKey
        
        
    let clinicPublicKey = clinicPublicKey
    
    let sSharedSecret = try! sPrivateKey.sharedSecretFromKeyAgreement(with: clinicPublicKey as! Curve25519.KeyAgreement.PublicKey)
    let sSymmetricKey = sSharedSecret.hkdfDerivedSymmetricKey(using: SHA256.self,
                                                              salt: protocolSalt,
                                                              sharedInfo: Data(),
                                                              outputByteCount: 32)
    
    let sSensitiveMessage = "The result of your test is positive".data(using: .utf8)!
    let nameSensitive = clientInfo.clientInfo1[0].name.data(using: .utf8)!
//    let ageSensitive = clientInfo.clientInfo1[0].age.data(using: .utf8)!
//    let civilIdSensitive = clientInfo.clientInfo1[0].civilID.data(using: .utf8)!
        
    let encryptedData = try! ChaChaPoly.seal(nameSensitive, using: sSymmetricKey).combined
    //let encryptedData2 = try! ChaChaPoly.seal(nameSensitive!, using: sSymmetricKey).combined
    //let encryptedData3 = try! ChaChaPoly.seal(ageSensitive!, using: sSymmetricKey).combined
    //let encryptedData4 = try! ChaChaPoly.seal(civilIdSensitive!, using: sSymmetricKey).combined
    
         
    print("EncryptedData: ")
    print(encryptedData)
    return  (encyptedMessage = encryptedData, clientPublicKey = sPublicKey)

}
    
    func decryptFunc(sPublicKey:Curve25519.KeyAgreement.PublicKey ,encryptedData: Data) {
        
        let protocolSalt = "Hello, playground".data(using: .utf8)!

        
        // receiver derives same symmetric key
        let rSharedSecret = try! clinicPrivateKey.sharedSecretFromKeyAgreement(with: sPublicKey)
        let rSymmetricKey = rSharedSecret.hkdfDerivedSymmetricKey(using: SHA256.self,
                                                                  salt: protocolSalt,
                                                                  sharedInfo: Data(),
                                                                  outputByteCount: 32)
        
         //receiver decrypts data
        let sealedBox = try! ChaChaPoly.SealedBox(combined: encryptedData)
        let decryptedData = try! ChaChaPoly.open(sealedBox, using: rSymmetricKey)
        let rSensitiveMessage = String(data: decryptedData, encoding: .utf8)!
        
        print("The message is:")
        print(rSensitiveMessage)
        
    }

}
    */
func getClinicPKey() {
    
    let rPrivateKey = Curve25519.KeyAgreement.PrivateKey()
    let rPublicKey = rPrivateKey.publicKey
    
    print(rPublicKey)
    
}
