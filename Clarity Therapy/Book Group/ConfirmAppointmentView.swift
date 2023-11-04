//
//  ConfirmAppointmentView.swift
//  Clarity Therapy
//
//  Created by Nawaf Almutairi on 25/03/2022.
//

import Foundation
import SwiftUI
import CryptoKit


// SORT TIME


struct ConfirmationStruct : Identifiable {
    
    var id = UUID()
    var clientName: String
    var clientPhone : String
    var clientPrivateKeyString: String
    var therapistName: String
    var therapistPublicKey: P256.KeyAgreement.PublicKey
    
    
}

struct EncryptionStruct : Identifiable {
    
    var id = UUID()
    var clientName: String
    var clientPhone : String
    var appointmentType: String
    var time: String
    var date: String
    
}

enum AppointmentType: String {
    case Remotely = "Remotely"
    case Inperson = "In person"
}


struct AppointmentTime : Identifiable,Hashable,Equatable {
    
    var id = UUID()
    var date : Date?
    var timeFrom : String
    var timeTo : String
    
    static func == (lhs: AppointmentTime, rhs: AppointmentTime) -> Bool {
        return lhs.date == rhs.date
        }
    
}





struct ConfirmAppointmentView: View {

    
    @Binding var isPresented: Bool
    @State var appointmentType = AppointmentType.Inperson.rawValue
    @EnvironmentObject var appointment : Appointments
    @EnvironmentObject var awsData : AWSData
    
    @State var selectedDate = Date()
    @State var selectedTime = ""
    @State var selectedYear = 2021
    // selectedMonth = currentMonth and above.
    @State var selectedMonth = 0
    @State var selectedDay = 1
    @State var avilableMonths = [Int]()

    
    @State var arrayTesting : [AppointmentTime] = [
                                            AppointmentTime(date: Formatter.yyyMMdd.date(from: "2/5/2022"), timeFrom: "9:00", timeTo: "17:00"),
                                            AppointmentTime(date: Formatter.yyyMMdd.date(from: "2/5/2022"), timeFrom: "11:00", timeTo: "17:00"),
                                            AppointmentTime(date: Formatter.yyyMMdd.date(from: "25/11/2022"), timeFrom: "12:00", timeTo: "15:00"),
                                            AppointmentTime(date: Formatter.yyyMMdd.date(from: "5/5/2022"), timeFrom: "9:00", timeTo: "17:00"),
                                            AppointmentTime(date: Formatter.yyyMMdd.date(from: "29/5/2022"), timeFrom: "12:00", timeTo: "15:00")]

    

    let convToDate = Date()
    let confirmView : ConfirmationStruct
    
    
    let columns = [
            GridItem(.adaptive(minimum: 80)),
            GridItem(.adaptive(minimum: 80)),
            GridItem(.adaptive(minimum: 80))
        ]

    var body: some View {
        

        VStack(spacing:5) {
            
            VStack {
            HStack {
                Text("Appointment Type:")
                .font(.title3)
                .bold()
                .foregroundColor(Color("text"))
                Spacer()
            }
           // .padding(.horizontal)
                            
                //Remotely
                HStack {
                    
                    Button {
                        appointmentType = AppointmentType.Inperson.rawValue
                    } label: {
                        Text("In-Person")
                            .bold()
                            .frame(width: 85,height: 15)
                            .foregroundColor(.white)
                            .buttonStyle(appointmentType == AppointmentType.Inperson.rawValue ? buttonChoiceStyle(color: "Myblue") : buttonChoiceStyle(color: "shadow"))
                        
                    }
                    
                    Button {
                        appointmentType = AppointmentType.Remotely.rawValue
                    } label: {
                        Text("Remote")
                            .bold()
                            .frame(width: 85,height: 15)
                            .foregroundColor(.white)
                            .buttonStyle(appointmentType == AppointmentType.Remotely.rawValue ? buttonChoiceStyle(color: "Myblue") : buttonChoiceStyle(color: "shadow"))

                    }
                    
                }
            
            }
            .onAppear {
                for _ in 0..<1 {
                    for x in arrayTesting {
                        let calendarDate = Calendar.current.dateComponents([.day, .year, .month], from: x.date!)
                        print(calendarDate)
                        avilableMonths.append(calendarDate.month!)
                    }
                }
            }
            .padding()
            
            VStack {
                
                HStack {
                    Text("Select Date:")
                    .font(.title3)
                    .bold()
                    .foregroundColor(Color("text"))
                    Spacer()
                }
                
                
                HStack {
                    ForEach(avilableMonths.uniqued().sorted(),id: \.self) { month in
                        
                        let dateFormatter: DateFormatter = DateFormatter()
                        let months = dateFormatter.shortMonthSymbols
                        let monthSymbol = months![month-1]
                        
                        Text("\(monthSymbol)")
                            .font(.callout)
                            .frame(width: 35,height:5)
                            .foregroundColor(.white)
                            .buttonStyle(selectedMonth == month ? buttonChoiceStyle(color: "Myblue") : buttonChoiceStyle(color: "shadow"))
                            .onTapGesture {
                                selectedMonth = month

                            }
                        
                        .onAppear {
                            for _ in 0..<1 {
                                for x in arrayTesting {
                                    let calendarDate = Calendar.current.dateComponents([.day, .year, .month], from: x.date!)
                                    print(calendarDate)
                                    avilableMonths.append(calendarDate.month!)
                                }
                            }
                        }
                        
                        
                    }
                    
                    Spacer()
                  
                    
                }
                
                ScrollView(.horizontal,showsIndicators: true) {
                    HStack {
                        
                        let uniqueDates = unique(dates: arrayTesting)
                        ForEach(uniqueDates) { day in
                            
                            let calendarDate = Calendar.current.dateComponents([.day, .year, .month], from: day.date!)

                            if calendarDate.month == selectedMonth {
                                
                                ZStack {
                                    RoundedRectangle(cornerRadius: 16)
                                        .foregroundColor(selectedDay == calendarDate.day! ? Color("Myblue") : Color("shadow"))
                                            .frame(width: 50, height: 75, alignment: .center)
                                    
                                    
                                    Text("\(Int(calendarDate.day!))")
                                        .font(.callout)
                                        .foregroundColor(.white)
                                        .onTapGesture{
                                            selectedDay = calendarDate.day!
                                            selectedDate = Formatter.yyyMMdd.date(from:"\(selectedDay)/\(selectedMonth)/2022")!
                                        }
              
                                    
                                    
                                }
                                   
                                
                            }
                            
                        }
                        
                        
                    }
                    
                }

                
            }
            .padding()
            .background(Color(hex: 0xF8F8F8))
            .animation(Animation.spring())
            
            VStack {
                HStack {
                    Text("Select Time:")
                    .font(.title3)
                    .bold()
                    .foregroundColor(Color("text"))
                    Spacer()
                }
                .padding(.top,15)
                
                let tempArray : [AppointmentTime] = arrayTesting.filter({$0.date == selectedDate})
                
                
                LazyVGrid(columns: columns){
                    ForEach(tempArray) { temp in
                        Text("\(Image(systemName: "clock")) \(temp.timeFrom)")
                            .bold()
                            .frame(width: 85,height: 15)
                            .foregroundColor(.white)
                            .buttonStyle(selectedTime == temp.timeFrom ?
                                         buttonChoiceStyle(color: "Myblue") :
                                        buttonChoiceStyle(color: "shadow") )
                            .onTapGesture{
                                selectedTime = temp.timeFrom
                            }
                    }
                }
                .animation(Animation.spring())

                
            }
            .padding()
            
            VStack {
                
                if selectedTime != "" {
                Button {
                    
                    
                    let clientPrivateKey = try! importPrivateKey(confirmView.clientPrivateKeyString)
                    let deriveSymmetricKey = try! deriveSymmetricKey(privateKey: clientPrivateKey, publicKey: confirmView.therapistPublicKey)
                    
                    let encrypted = EncryptionStruct(clientName: confirmView.clientName, clientPhone: confirmView.clientPhone, appointmentType: appointmentType, time: selectedTime, date: selectedDate.toString(dateFormat: "dd/MM/yyyy"))
                                    
                    let messageEncrypted = try! encrypt(input: encrypted, symmetricKey: deriveSymmetricKey)
                    
                    appointment.appointmentArray.append(AppointmentStruct(messagesEncrypted: messageEncrypted, therapistPublicKey: confirmView.therapistPublicKey, clientPublicKey: clientPrivateKey.publicKey))
                    
                } label: {
                    Text("Book your Appointment")
                        .bold()
                        .frame(width: 275,height: 15)
                        .foregroundColor(.white)
                        .buttonStyle(appointmentType == AppointmentType.Inperson.rawValue ? buttonChoiceStyle(color: "Myblue") : buttonChoiceStyle(color: "shadow"))
                    
                }
                .animation(Animation.spring())
                }
            }
            
            
            /*
            Spacer()
            
            
            Button {
                
                let clientPrivateKey = try! importPrivateKey(confirmView.clientPrivateKeyString)
                let deriveSymmetricKey = try! deriveSymmetricKey(privateKey: clientPrivateKey, publicKey: confirmView.therapistPublicKey)
                
                let encrypted = EncryptionStruct(clientName: confirmView.clientName, clientPhone: confirmView.clientPhone, appointmentType: appointmentType, time: selectedTime, date: selectedDate)
                                
                let messageEncrypted = try! encrypt(input: encrypted, symmetricKey: deriveSymmetricKey)
                
                appointment.appointmentArray.append(AppointmentStruct(messagesEncrypted: messageEncrypted, therapistPublicKey: confirmView.therapistPublicKey, clientPublicKey: clientPrivateKey.publicKey))
                
            } label: {
                Text("Confirm")
                    .frame(width: 250)
                    .foregroundColor(.white)
                    .buttonStyle(buttonChoiceStyle(color: "Myblue"))
                
            }

            Button {

                self.isPresented = false
                //self.nextView = true

            } label: {
                Text("Dismiss")
                    .frame(width: 250)
                    .foregroundColor(.white)
                    .buttonStyle(buttonChoiceStyle(color: "Myblue"))

            }
            */
            Spacer()
                
//                .background(EmptyView().sheet(isPresented: $nextView, onDismiss: {
//                    self.nextView = false
//                }, content: {
//                    TherapistView(isPresented: $nextView)
//                }))
            
        }

        
    }

}


struct ConfirmAppointmentView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmAppointmentView(isPresented: .constant(true), confirmView: ConfirmationStruct(clientName: "", clientPhone: "", clientPrivateKeyString: "", therapistName: "", therapistPublicKey: generatePrivateKey().publicKey))
    }
}

extension Date {
    init(_ dateString:String) {
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "dd/MM/yyyy"
        dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
        let date = dateStringFormatter.date(from: dateString)!
        self.init(timeInterval:0, since:date)
    }
}

extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

}


extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}


func unique(dates: [AppointmentTime]) -> [AppointmentTime] {

    var uniqueDates = [AppointmentTime]()

    for date in dates {
        if !uniqueDates.contains(date) {
            uniqueDates.append(date)
        }
    }

    return uniqueDates
}
