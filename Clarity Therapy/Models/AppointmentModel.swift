//
//  AppointmentModel.swift
//  Clarity Therapy
//
//  Created by Nawaf Almutairi on 16/04/2022.
//

import Foundation
import CryptoKit

struct AppointmentStruct: Identifiable {
    
    var id = UUID()
    var messageEncrypted : String
    var therapistPublicKey : P256.KeyAgreement.PublicKey
    var clientPublicKey : P256.KeyAgreement.PublicKey
    
}
