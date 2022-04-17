//
//  MyUserModel.swift
//  Clarity Therapy
//
//  Created by Nawaf Almutairi on 16/04/2022.
//

import Foundation


struct MyUser : Identifiable {
    
    var id = UUID()
    var name: String
    var privateKey: String
    
}
