//
//  MyUserClientVM.swift
//  Clarity Therapy
//
//  Created by Nawaf Almutairi on 16/04/2022.
//

import Foundation
import CryptoKit


@MainActor class MyUserClient : ObservableObject {
    
    @Published var myUserClient : [MyUser]
    
    init () {
        myUserClient = [MyUser(name: "Nawaf Almutairi", privateKey: exportPrivateKey(P256.KeyAgreement.PrivateKey()))]
    }
    
}
