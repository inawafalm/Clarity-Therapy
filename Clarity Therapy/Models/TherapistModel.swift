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
    var image  = ""
    var type = ""
    var price = ""
    var remotely = false
    var inperson = false
    var experience = ""
    var qualifactions = ""
    var language = ""
    var Description = ""
    var therapistPublicKey = generatePrivateKey().publicKey
    
}
