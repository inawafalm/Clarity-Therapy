//
//  ModelsOld.swift
//  Clarity Therapy
//
//  Created by Nawaf Almutairi on 11/04/2022.
//

import Foundation
import SwiftUI
import CryptoKit

// DATA


func importPrivateKey(_ privateKey: String) throws -> P256.KeyAgreement.PrivateKey {
    let privateKeyBase64 = privateKey.removingPercentEncoding!
    let rawPrivateKey = Data(base64Encoded: privateKeyBase64)!
    return try P256.KeyAgreement.PrivateKey(rawRepresentation: rawPrivateKey)
}

func generatePrivateKey() -> P256.KeyAgreement.PrivateKey {
    let privateKey = P256.KeyAgreement.PrivateKey()
    return privateKey
}

func exportPrivateKey(_ privateKey: P256.KeyAgreement.PrivateKey) -> String {
    let rawPrivateKey = privateKey.rawRepresentation
    let privateKeyBase64 = rawPrivateKey.base64EncodedString()
    let percentEncodedPrivateKey = privateKeyBase64.addingPercentEncoding(withAllowedCharacters: .alphanumerics)!
    return percentEncodedPrivateKey
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

func encrypt(input: EncryptionStruct, symmetricKey: SymmetricKey) throws -> EncryptionStruct {
    
    
    let nameData = input.clientName.data(using: .utf8)!
    let phoneData = input.clientPhone.data(using: .utf8)!
    let apptType = input.appointmentType.data(using: .utf8)!
    let time = input.time.data(using: .utf8)!
    let date = input.date.data(using: .utf8)!

    let encrypted = try AES.GCM.seal(nameData, using: symmetricKey)
    let encrypted1 = try AES.GCM.seal(phoneData, using: symmetricKey)
    let encrypted2 = try AES.GCM.seal(apptType, using: symmetricKey)
    let encrypted3 = try AES.GCM.seal(time, using: symmetricKey)
    let encrypted4 = try AES.GCM.seal(date, using: symmetricKey)
    
let test = EncryptionStruct(clientName: encrypted.combined!.base64EncodedString(), clientPhone: encrypted1.combined!.base64EncodedString(), appointmentType: encrypted2.combined!.base64EncodedString(), time: encrypted3.combined!.base64EncodedString(), date: encrypted4.combined!.base64EncodedString())
    return test
}

func decrypt(input: EncryptionStruct, symmetricKey: SymmetricKey) throws -> EncryptionStruct {
    
    let data = Data(base64Encoded: input.clientName)
    let data1 = Data(base64Encoded: input.clientPhone)
    let data2 = Data(base64Encoded: input.appointmentType)
    let data3 = Data(base64Encoded: input.time)
    let data4 = Data(base64Encoded: input.date)
    
    
    //0
    let sealedBox = try AES.GCM.SealedBox(combined: data!)
    let decryptedData = try AES.GCM.open(sealedBox, using: symmetricKey)
    let text = String(data: decryptedData, encoding: .utf8)
    //1
    let sealedBox1 = try AES.GCM.SealedBox(combined: data1!)
    let decryptedData1 = try AES.GCM.open(sealedBox1, using: symmetricKey)
    let text1 = String(data: decryptedData1, encoding: .utf8)
    
    //2
    let sealedBox2 = try AES.GCM.SealedBox(combined: data2!)
    let decryptedData2 = try AES.GCM.open(sealedBox2, using: symmetricKey)
    let text2 = String(data: decryptedData2, encoding: .utf8)
    //3
    let sealedBox3 = try AES.GCM.SealedBox(combined: data3!)
    let decryptedData3 = try AES.GCM.open(sealedBox3, using: symmetricKey)
    let text3 = String(data: decryptedData3, encoding: .utf8)
    //4
    let sealedBox4 = try AES.GCM.SealedBox(combined: data4!)
    let decryptedData4 = try AES.GCM.open(sealedBox4, using: symmetricKey)
    let text4 = String(data: decryptedData4, encoding: .utf8)
    
    
    let test = EncryptionStruct(clientName: text!, clientPhone: text1!, appointmentType: text2!, time: text3!, date: text4!)
    return test
    
/*
    do {
        guard let data = Data(base64Encoded: input.clientName),
              let data1 = Data(base64Encoded: input.clientPhone),
              let data2 = Data(base64Encoded: input.appointmentType),
              let data3 = Data(base64Encoded: input.time),
              let data4 = Data(base64Encoded: input.date)
        else {
            print("Could not decode text: \(input)")
        }
        
        //0
        let sealedBox = try AES.GCM.SealedBox(combined: data)
        let decryptedData = try AES.GCM.open(sealedBox, using: symmetricKey)
        //1
        let sealedBox1 = try AES.GCM.SealedBox(combined: data1)
        let decryptedData1 = try AES.GCM.open(sealedBox1, using: symmetricKey)
        
        //2
        let sealedBox2 = try AES.GCM.SealedBox(combined: data2)
        let decryptedData2 = try AES.GCM.open(sealedBox2, using: symmetricKey)
        //3
        let sealedBox3 = try AES.GCM.SealedBox(combined: data3)
        let decryptedData3 = try AES.GCM.open(sealedBox3, using: symmetricKey)
        //4
        let sealedBox4 = try AES.GCM.SealedBox(combined: data4)
        let decryptedData4 = try AES.GCM.open(sealedBox4, using: symmetricKey)
        
        let test = EncryptionStruct(clientName: text, clientPhone: text1, appointmentType: text2, time: text3, date: text4)
        return test
        
        
        //0
        guard let text = String(data: decryptedData, encoding: .utf8) else {
            return "Could not decode data: \(decryptedData)"
        }
        
        //1
        guard let text1 = String(data: decryptedData1, encoding: .utf8) else {
            return "Could not decode data: \(decryptedData1)"
        }
        
        //2
        guard let text2 = String(data: decryptedData2, encoding: .utf8) else {
            return "Could not decode data: \(decryptedData2)"
        }
        
        //3
        guard let text3 = String(data: decryptedData3, encoding: .utf8) else {
            return "Could not decode data: \(decryptedData3)"
        }
        
        //4
        guard let text4 = String(data: decryptedData4, encoding: .utf8) else {
            return "Could not decode data: \(decryptedData4)"
        }
        
        let test = EncryptionStruct(clientName: text, clientPhone: text1, appointmentType: text2, time: text3, date: text4)
        return test
        
    } catch let error {
        return "Error decrypting message: \(error.localizedDescription)"
    }*/
}
