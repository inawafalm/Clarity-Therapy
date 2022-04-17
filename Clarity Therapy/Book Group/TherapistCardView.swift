//
//  TherapistCardView.swift
//  Clarity Therapy
//
//  Created by Nawaf Almutairi on 05/02/2022.
//

import Foundation
import SwiftUI


struct TherapistCardView: View {
    


    @State var clinicName : String
    @State var image : String
    @State var type: String
    @State var inperson: Bool
    @State var remotely: Bool

    
    var body: some View {
        
        
        ZStack {
            // Rectangle
            RoundedRectangle(cornerRadius: 20.0)
                .foregroundColor(.white)
                .frame(height: 160)
                .shadow(color: Color("shadow"), radius: 3, x: 0.5, y: 0.5)

            HStack {
                Spacer()
                Image(systemName: "chevron.forward")
                    .foregroundColor(Color("shadow"))
                
            }
            .padding(.trailing,5)
            
            VStack() {
                
                    HStack {
                            Image(image)
                                .resizable()
                                .clipShape(Circle())
                                .shadow(radius: 10)
                                .frame(width: 75, height: 75)
                            .padding(5)
                            
                            VStack(alignment:.leading){
                                Text(clinicName)
                                    .font(.title3)
                                    .foregroundColor(Color("text"))
                                Text(type)
                                    .font(.footnote)
                                    .fontWeight(.light)
                                //Remotely
                                HStack {
                                    if remotely {
                                    Capsule()
                                            .fill(Color("Myblue"))
                                            .shadow(color:Color("shadow"), radius: 2, x: 1, y: 1)
                                            .overlay(
                                                Text("Remotely")
                                                    .font(.footnote)
                                                    .foregroundColor(.white)
                                            )
                                        .frame(minWidth: 75, maxWidth: 75, minHeight: 30,maxHeight: 30)
                                    }
                                    if inperson {
                                    Capsule()
                                            .fill(Color("Myblue"))
                                            .shadow(color:Color("shadow"), radius: 2, x: 1, y: 1)
                                            .overlay(
                                                Text("In person")
                                                    .font(.footnote)
                                                    .foregroundColor(.white)
                                            )
                                            .frame(minWidth: 75, maxWidth: 75, minHeight: 30,maxHeight: 30)
                                    }
                                }
                                
                            }
                            .padding(.top,15)
                            Spacer()
                        
                        }
                    .padding(.leading,-10)
                
                
                HStack {
                    Spacer()
                    Text("Available next Monday").font(.system(size: 10,weight: .bold))
                        .foregroundColor(Color("text"))

                }
                .padding(.top)
            }
            .padding()
                
                
                /*
                VStack(alignment:.leading) {
                    //Remotely
                    HStack {
                        Capsule()
                                .fill(Color("Myblue"))
                                .shadow(color:Color("shadow"), radius: 2, x: 1, y: 1)
                                .overlay(
                                    Text("Remotely")
                                        .font(.footnote)
                                        .foregroundColor(.white)
                                )
                            .frame(maxWidth:75,maxHeight: 30)
                        Capsule()
                                .fill(Color("Myblue"))
                                .shadow(color:Color("shadow"), radius: 2, x: 1, y: 1)
                                .overlay(
                                    Text("In person")
                                        .font(.footnote)
                                        .foregroundColor(.white)
                                )
                            .frame(maxWidth:75,maxHeight: 30)
                    }
                    
                                    
                    HStack {
                        Spacer()
                        Text("Available next Monday").font(.system(size: 10,weight: .bold))
                            .foregroundColor(Color("text"))

                    }
                                    
                }
                .font(.system(size:12))
                */
                //Spacer()
                
            
            

        }
       // .padding(.horizontal,10)
        
    
    }
    
    
    
}



struct TherapistCardView_Previews: PreviewProvider {
    static var previews: some View {
        TherapistCardView(clinicName: "Alejandra", image: "alej", type: "Counsler", inperson: true, remotely: true)
}
}
