//
//  Clarity_TherapyApp.swift
//  Clarity Therapy
//
//  Created by Nawaf Almutairi on 04/02/2022.
//

import SwiftUI

@main
struct Clarity_TherapyApp: App {
    var body: some Scene {
        WindowGroup {
            AppView()
           // DetailClinicView(clinicName: "", clinicPKey: "")
        }
    }
}


struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AppView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
                .previewDisplayName("iPhone 12 Pro Max")
                //.environment(\.locale, Locale(identifier: "ar"))
//
//            AppView()
//                .previewDevice(PreviewDevice(rawValue: "iPhone 12 pro"))
//                .previewDisplayName("iPhone 12 pro")
//
//            AppView()
//                .previewDevice(PreviewDevice(rawValue: "iPhone 12 mini"))
//                .previewDisplayName("iPhone 12 mini")
//
//            AppView()
//                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
//                .previewDisplayName("iPhone 8")
            
        }
    }
}


