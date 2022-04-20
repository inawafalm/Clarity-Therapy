//
//  DetailView.swift
//  Clarity Therapy
//
//  Created by Nawaf Almutairi on 25/03/2022.
//

import Foundation
import SwiftUI
import CryptoKit


struct DetailStruct : Identifiable {
    
    var id = UUID()
    var therapistName : String
    var image : String
    var type: String
    var price: String
    var remotely: Bool?
    var inperson: Bool?
    var experience: String
    var qualifactions: String
    var language: String
    var Description: String
    var clientName: String
    var clientPhone: String
    var clientPrivateKeyString: String
    var therapistPublicKey: P256.KeyAgreement.PublicKey
    
}


struct DetailView: View {
    

    let detailViewItems: DetailStruct
    
    @State var isPresentingConfirmation = false
    @EnvironmentObject var appointment : Appointments
    @EnvironmentObject var awsData : AWSData
    
    
    //@State var encyptedMessage = Data()



    var body: some View {
        
        VStack{
            VStack {
                HStack {
                    Image(detailViewItems.image)
                            .resizable()
                            .clipShape(Circle())
                            .shadow(color: Color("shadow"), radius: 3, x: 0.5, y: 0.5)
                            .frame(width: 100, height: 100)
                        .padding(5)
                        
                        VStack(alignment:.leading){
                            Text(detailViewItems.therapistName)
                                .font(.title3)
                                .foregroundColor(Color("text"))
                            Text(detailViewItems.type)
                                .font(.footnote)
                                .fontWeight(.light)
                            
                        }
                        //.padding(.top,5)
                        Spacer()
                    
                    }
                .padding()
                
                Divider()
                    .padding(.horizontal)
                
                VStack(spacing:5){
                    
    //                HStack{
    //
    //                    Image(systemName: "heart.text.square.fill")
    //                        .font(.title2)
    //                        .foregroundColor(Color("Myblue"))
    //
    //                    Text("Type:")
    //                        .foregroundColor(Color(type))
    //                        .bold()
    //
    //                    Text("Psycological")
    //                    Spacer()
    //                }.padding(.horizontal)
                    
                    
                    HStack{
                        
                        Image(systemName: "heart.text.square.fill")
                            .font(.title2)
                            .foregroundColor(Color("Myblue"))
                        
                        Text("Price:")
                            .foregroundColor(Color("text"))
                            .bold()
                        
                        Text(detailViewItems.price)
                        Spacer()
                    }.padding(.horizontal)
                    
                    
                    HStack{
                        
                        Image(systemName: "heart.text.square.fill")
                            .font(.title2)
                            .foregroundColor(Color("Myblue"))
                        
                        Text("Method:")
                            .foregroundColor(Color("text"))
                            .bold()
                        HStack {
                            if detailViewItems.inperson ?? false {
                        Text("In-Person")
                            }
                            if detailViewItems.remotely ?? false {
                                Text("Remotely")
                            }
                        }
                        Spacer()
                    }.padding(.horizontal)
                }
                .padding(.top)
                
                VStack(spacing:10){
                    
                    HStack{
                        
                        Text("Experience:")
                            .bold()
                        Spacer()
                        Text(detailViewItems.experience)
                        
                    }.padding(.horizontal)
                    
                    
                    HStack{
                        
                        Text("Qualifactions:")
                            .bold()
                        Spacer()
                        Text(detailViewItems.qualifactions)
                        
                    }.padding(.horizontal)
                    
                    
                    HStack{
                        
                        Text("Language")
                            .bold()
                        Spacer()
                        Text(detailViewItems.language)
                        
                    }.padding(.horizontal)
                    
                    VStack{
                        
                        HStack {
                            Text("Description")
                                .bold()
                            Spacer()

                        }
                        HStack {
                            Text(detailViewItems.Description)
                                .offset(y:-20)
                            Spacer()
                        }
                        .padding()
                        
                    }.padding(.horizontal)
                }
                .background(Color(hex: 0xF8F8F8))
                .padding(.top)
                
                Spacer()
                
                Button {
                    self.isPresentingConfirmation.toggle()

                } label: {
                    Text("Book a Session")
                        .frame(width: 250)
                        .foregroundColor(.white)
                        .buttonStyle(buttonChoiceStyle(color: "Myblue"))
                    
                }.background(
//                    NavigationLink(destination: ConfirmAppointmentView(isPresented: $isPresentingConfirmation, confirmView: ConfirmationStruct(clinicName: detailViewItems.therapistName, clientPrivateKeyString: detailViewItems.clientPrivateKeyString, therapistPublicKey: detailViewItems.therapistPublicKey)), isActive: $isPresentingConfirmation) {}
                    
                    NavigationLink(destination: ConfirmAppointmentView(isPresented: $isPresentingConfirmation,confirmView: ConfirmationStruct(clientName: detailViewItems.clientName, clientPhone: detailViewItems.clientPhone, clientPrivateKeyString: detailViewItems.clientPrivateKeyString, therapistName: detailViewItems.therapistName, therapistPublicKey: detailViewItems.therapistPublicKey)), isActive: $isPresentingConfirmation){}
                )
                
                Spacer()
                
            }

        }
.navigationBarTitleDisplayMode(.inline)
        
        

        
    }
    
    
    
}



struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        DetailView(detailViewItems: DetailStruct(therapistName: "Alejandra", image: "alej", type: "LMFT", price: "50KD", experience: "3 Years", qualifactions: "M.A", language: "Spanish,English", Description: "", clientName: "", clientPhone: "", clientPrivateKeyString: "", therapistPublicKey: generatePrivateKey().publicKey))
            .environmentObject(AWSData())
    }
}


extension Color {
    init(hex: Int, opacity: Double = 1.0) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}
