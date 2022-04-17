//
//  ContentView.swift
//  Clarity Therapy
//
//  Created by Nawaf Almutairi on 04/02/2022.
//
import SwiftUI
import CryptoKit



struct ContentView: View {
        
    @State var selectedTherapist: TherapistModel? = nil
    @State var isPresentingClinic = false


    @EnvironmentObject var appointment : Appointments
    @EnvironmentObject var awsData : AWSData
    @EnvironmentObject var therapistApp : TherapistApp
    @EnvironmentObject var myUserClient : MyUserClient
   
    var body: some View {
        NavigationView {
            VStack{
                ScrollView(.vertical) {
                ForEach(awsData.therapistsArray) { therapist in
                    let privateKey = myUserClient.myUserClient[0].privateKey
                    NavigationLink(destination:DetailView(clientPrivateKeyString: privateKey, therapistPublicKey: therapist.therapistPublicKey)){
                        TherapistCardView(clinicName: therapist.name, image: therapist.name, type: "Test", inperson: true, remotely: true)
                            .padding(10)
                    }
                }
                .onAppear {
                        UITableView.appearance().backgroundColor = UIColor.clear
                        UITabBar.appearance().barTintColor = UIColor(named: "Myblue")
                }
                .navigationTitle("Therapists")
                
            }.listStyle(GroupedListStyle())
            
             
                VStack{
                Text("Fetch Data")
                    .onTapGesture {
                        var data = TherapistModel()
                        data.name = therapistApp.myUserTherapist[0].name
                        data.therapistPublicKey = try! importPrivateKey(therapistApp.myUserTherapist[0].privateKey).publicKey
                        awsData.therapistsArray.append(data)
                    }
                    
                }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AWSData())
    }
}
