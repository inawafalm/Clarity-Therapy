//
//  AppView.swift
//  Clarity Therapy
//
//  Created by Nawaf Almutairi on 19/03/2022.
//

import Foundation
import SwiftUI
import CryptoKit


struct AppView: View {
    var body: some View {
            TabBarView()
    }
}


struct TabBarView : View {
    
    @State var tab1 = "house.circle"
    @State var tab2 = "calendar.circle"
    @State var tab3 = "gearshape"
    @State private var selection = 0
    
    @StateObject var appointments = Appointments()
    @StateObject var awsData = AWSData()
    @StateObject var therapistApp = TherapistApp()
    @StateObject var myUserClient = MyUserClient()

    
    init() {
        setupTabBar()
        
        if #available(iOS 15.0, *) {
        UITabBar.appearance().backgroundColor = UIColor(named: "Mywhite")
        }
    }
    
    var body: some View{
        
        
        TabView(selection: $selection) {
            ContentView().tabItem
            {
                    Image(systemName: tab1)
                    Text("Home")
                
            }.tag(0)
               
        //isPresented: .constant(false), clientPublicKey: clientPK.publicKey
            TherapistView(isPresented: .constant(false))
                .tabItem {
                    Image(systemName: tab3)
                        Text("Settings")
                }
                .tag(2)

            
        }.accentColor(Color("Myblue"))
            .environmentObject(appointments)
            .environmentObject(awsData)
            .environmentObject(therapistApp)
            .environmentObject(myUserClient)
        
        
    }
}


struct AppVieaaw_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
            .environmentObject(Appointments())
            .environmentObject(AWSData())
            .environmentObject(TherapistApp())
            .environmentObject(MyUserClient())
    }
}
