//
//  TherapistModel.swift
//  Clarity Therapy
//
//  Created by Nawaf Almutairi on 16/04/2022.
//

import Foundation



struct TherapistModel : Identifiable {
    
    var id = UUID()
    var name = ""
    var therapistPublicKey = generatePrivateKey().publicKey
    
}
