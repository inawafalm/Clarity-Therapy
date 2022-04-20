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
        myUserClient = [MyUser(name: "Nawaf Almutairi", phone: "786-781-7435", privateKey: exportPrivateKey(P256.KeyAgreement.PrivateKey())),
                        MyUser(name: "Lisa A.", phone: "305-305-3005", privateKey: exportPrivateKey(P256.KeyAgreement.PrivateKey()))]
        
    }
    
}
