//
//  TherapistsList.swift
//  Clarity Therapy
//
//  Created by Nawaf Almutairi on 16/04/2022.
//

import Foundation


@MainActor class AWSData : ObservableObject {
  
    @Published var therapistsArray : [TherapistModel]
    
    init() {
        therapistsArray = []
    }
}
