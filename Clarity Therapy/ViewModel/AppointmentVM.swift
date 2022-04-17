//
//  AppointmentVM.swift
//  Clarity Therapy
//
//  Created by Nawaf Almutairi on 16/04/2022.
//

import Foundation

@MainActor class Appointments: ObservableObject {
    
    @Published var appointmentArray : [AppointmentStruct]
    
    init() {
        appointmentArray = []
    }
    
}
