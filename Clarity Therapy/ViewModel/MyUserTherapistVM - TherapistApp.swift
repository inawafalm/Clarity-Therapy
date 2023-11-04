//
//  MyUserTherapistVM - TherapistApp.swift
//  Clarity Therapy
//
//  Created by Nawaf Almutairi on 16/04/2022.
//

import Foundation
import CryptoKit


@MainActor class TherapistApp : ObservableObject {
    
    @Published var myUserTherapist : [MyUser]
    
    init () {
        myUserTherapist = [MyUser(name: "Alejandra M.", phone: "305-339-3333", privateKey: exportPrivateKey(P256.KeyAgreement.PrivateKey()))]
    }
    
}

