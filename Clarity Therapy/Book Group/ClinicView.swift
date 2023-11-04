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
    
    @State private var myUser : MyUser?
   
    var body: some View {
        NavigationView {
            VStack{
                HStack {
                    Button {

                        myUser = myUserClient.myUserClient[0]
                        
                    } label: {
                        Text("Nawaf")
                            .font(.callout)
                            .frame(width: 50)
                            .foregroundColor(.white)
                            .buttonStyle(buttonChoiceStyle(color: "Myblue"))
                        
                    }
                    Button {

                        myUser = myUserClient.myUserClient[1]

                        
                    } label: {
                        Text("Moha")
                            .font(.callout)
                            .frame(width: 50)
                            .foregroundColor(.white)
                            .buttonStyle(buttonChoiceStyle(color: "Myblue"))
                        
                    }
                }
                ScrollView(.vertical) {
                ForEach(awsData.therapistsArray) { therapist in
                    NavigationLink(destination:
                                    DetailView(detailViewItems:
                                                DetailStruct(therapistName: therapist.name,
                                                             image: therapist.image,
                                                             type: therapist.type, price: therapist.price,
                                                             remotely:therapist.remotely,
                                                             inperson:therapist.inperson,
                                                             experience: therapist.experience,
                                                             qualifactions: therapist.qualifactions,
                                                             language:therapist.language,
                                                             Description: therapist.Description,
                                                             clientName:myUser!.name,
                                                             clientPhone:myUser!.phone,
                                                             clientPrivateKeyString:myUser!.privateKey,
                                                             therapistPublicKey: therapist.therapistPublicKey))
                    ){
                        TherapistCardView(clinicName: therapist.name, image: therapist.name, type: therapist.type, inperson: therapist.inperson, remotely: therapist.remotely)
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
                        data.image = therapistApp.myUserTherapist[0].name
                        data.type = "Clinical Psychologist"
                        data.price = "30KD - 60min"
                        data.remotely = true
                        data.inperson = false
                        data.experience = "4 Years"
                        data.qualifactions = "M.A"
                        data.language = "English"
                        data.Description = "Clinical Psychologist from The University of Miami with 4 years of experience. She is prusing her PhD degree in Mental Health Counsling from UGA"
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
