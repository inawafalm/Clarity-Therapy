//
//  Cryptography.swift
//  Clarity Therapy
//
//  Created by Nawaf Almutairi on 21/02/2022.
//

import Foundation
import CryptoKit
import SwiftUI

//struct clientStruct {
//
//    var name : String
//    var age: String
//    var civilID: String
//    var clientPrivateKey: Curve25519.KeyAgreement.PrivateKey
//    var clientPublicKey : Curve25519.KeyAgreement.PublicKey
//
//}

// USER AKA Client
/*
    - Signin
    - Get User info ( Public and Private Key )
    - keep in the Public Key and Private Key in @Published varriable
    - Call Public Key from the Clinic and Generate "Secret Info"
    - Send it to the Clinic
*/

// Clinic

/*
    - Signin
    - get the User(Client) Public key
    - Encrypt the massage
 */



/*
class encryption: ObservableObject {
    
    @ObservedObject var clientInfo = NetworkFirebase()
    
    @Published var encryptedMessage = Data()
    @Published var clinicPrivateKey = Curve25519.KeyAgreement.PrivateKey()
    @Published var clientPublicKey : Curve25519.KeyAgreement.PublicKey
    
//    @Published var clientPublicKey = {
//        clinicPrivateKey.publicKey.rawRepresentation
//    }()

    
    init(clinicPrivateKey:Curve25519.KeyAgreement.PrivateKey,clinicPublicKey:Curve25519.KeyAgreement.PublicKey) {
        
        self.clinicPrivateKey = clinicPrivateKey
        self.clientPublicKey = clinicPrivateKey.publicKey

    }



    func encryptionFunc(clinicPublicKey: Any) -> (Any,Any) {

    let protocolSalt = "Hello, playground".data(using: .utf8)!
    // generate key pairs
        
    // From the Data (Client)
    let sPrivateKey = clientInfo.clientInfo1!.clientPrivateKey
    let sPublicKey = clientInfo.clientInfo1!.clientPublicKey
    //var cPublicKey = clinicPrivateKey.publicKey

    let clinicPublicKey = clinicPublicKey

    let sSharedSecret = try! sPrivateKey.sharedSecretFromKeyAgreement(with: clinicPublicKey as! Curve25519.KeyAgreement.PublicKey)
    let sSymmetricKey = sSharedSecret.hkdfDerivedSymmetricKey(using: SHA256.self,
                                                              salt: protocolSalt,
                                                              sharedInfo: Data(),
                                                              outputByteCount: 32)

    let sSensitiveMessage = "The result of your test is positive".data(using: .utf8)!
    let nameSensitive = clientInfo.clientInfo1?.name.data(using: .utf8)!
    let ageSensitive = clientInfo.clientInfo1?.age.data(using: .utf8)!
    let civilIdSensitive = clientInfo.clientInfo1?.civilID.data(using: .utf8)!

    let encryptedData = try! ChaChaPoly.seal(sSensitiveMessage, using: sSymmetricKey).combined
    let encryptedData2 = try! ChaChaPoly.seal(nameSensitive!, using: sSymmetricKey).combined
    //let encryptedData3 = try! ChaChaPoly.seal(ageSensitive!, using: sSymmetricKey).combined
    //let encryptedData4 = try! ChaChaPoly.seal(civilIdSensitive!, using: sSymmetricKey).combined


    print("EncryptedData: ")
    print(encryptedData)
    return  (encryptedMessage = encryptedData2, clientPublicKey = sPublicKey)

}
    
    
    func decryptFunc(sPublicKey:Curve25519.KeyAgreement.PublicKey ,encryptedData: Data) {
        
        let protocolSalt = "Hello, playground".data(using: .utf8)!

        
        // receiver derives same symmetric key
        let rSharedSecret = try! clinicPrivateKey.sharedSecretFromKeyAgreement(with: sPublicKey)
        let rSymmetricKey = rSharedSecret.hkdfDerivedSymmetricKey(using: SHA256.self,
                                                                  salt: protocolSalt,
                                                                  sharedInfo: Data(),
                                                                  outputByteCount: 32)
        
        // receiver decrypts data
        let sealedBox = try! ChaChaPoly.SealedBox(combined: encryptedData)
        let decryptedData = try! ChaChaPoly.open(sealedBox, using: rSymmetricKey)
        let rSensitiveMessage = String(data: decryptedData, encoding: .utf8)!
        
        print("The message is:")
        print(rSensitiveMessage)
        
    }

}
*/
