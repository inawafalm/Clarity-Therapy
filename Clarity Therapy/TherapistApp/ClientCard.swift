//
//  ClientCard.swift
//  Clarity Therapy
//
//  Created by Nawaf Almutairi on 19/04/2022.
//

import SwiftUI
import Foundation

struct ClientCardView: View {
    

    @State var name : String
    @State var phone : String
    @State var type: String
    @State var time : String
    @State var date: String

    
    var body: some View {
        
        
        ZStack {
            // Rectangle
            RoundedRectangle(cornerRadius: 20.0)
                .foregroundColor(.white)
                .frame(height: 125)
                .shadow(color: Color("shadow"), radius: 3, x: 0.5, y: 0.5)

            HStack {
                Spacer()
                Image(systemName: "chevron.forward")
                    .foregroundColor(Color("shadow"))
                
            }
            .padding(.trailing,5)
            
 
                            
            VStack {
                    VStack(alignment:.leading,spacing: 5){
                        HStack{
                            Image(systemName: "person.fill")
                                .font(.title2)
                                .foregroundColor(Color("Myblue"))
                            
                            Text("Name:")
                                .foregroundColor(Color("text"))
                                .bold()
                            
                            Text(name)
                                .foregroundColor(Color.black)
                            Spacer()
                        }
                        
                        HStack{
                            Image(systemName: "heart.text.square.fill")
                                .font(.title2)
                                .foregroundColor(Color("Myblue"))
                            
                            Text("Method:")
                                .foregroundColor(Color("text"))
                                .bold()
                            
                            Text(type)
                                .foregroundColor(Color.black)
                            Spacer()
                        }

                    }
                VStack(){
                
                    HStack {
                        Image(systemName: "calendar")
                        Text(time)
                            .foregroundColor(Color.black)
                        Text(date)
                            .foregroundColor(Color.black)

                        
                    }
                }
                .frame(width: 300, height: 30)
                .background(Color(hex: 0xF8F8F8))
                .cornerRadius(20.0)
            }
            .padding()
      

        }
      
    }
    
    
    
}



struct ClientCardView_Previews: PreviewProvider {
    static var previews: some View {
        ClientCardView(name: "Nawaf Almutairi", phone: "786781", type: "In person", time: "10:09AM", date: "11/11/2022")
}
}
