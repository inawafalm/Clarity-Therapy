//
//  testing.swift
//  Clarity Therapy
//
//  Created by Nawaf Almutairi on 31/03/2022.
//

import Foundation
import SwiftUI

struct Testing_ContentView: View {
    
    
    @State var selectedYear = 2021
    @State var selectedMonth = 0
    @State var selectedDay = 0
    @State var availableDates = [["2","10","13","22"],["1","3","4","9"],["20","21","22","23"]]
    
    
    
    var body: some View {
        
        VStack(spacing:25){
            
            HStack {
                Text("2021")
                    .onTapGesture {
                        selectedYear = 2021
                    }
                Text("2022")
                    .onTapGesture {
                        selectedYear = 2022
                    }
            }
            
            Text("Months")
           
            ScrollView(.horizontal) {
                HStack{
                   // let monthAsNr = Calendar.current.component(.month, from: Date())
                    
                ForEach(Array(availableDates.enumerated()),id: \.element){ index , month in
                    
                        Button {
                        
                            selectedMonth = index
                            print(selectedMonth)
                            
                            let monthName = DateFormatter().monthSymbols[selectedMonth - 1]

                            let dateFormatter: DateFormatter = DateFormatter()

                            let months = dateFormatter.shortMonthSymbols
                            let monthSymbol = months![selectedMonth-1] as! String // month - from your date components

                            
                            print(monthSymbol)
                        
                                
                            
                        } label: {

                            Text("Hi")
                        }
                    }
                }
            }
            
            
            /*HStack {
                HStack {
                    ForEach(availableDates[selectedMonth],id:\.self) { day in
                       
                        
                        Button {

                            
                            selectedDay = Int(day)!

                            
                        } label: {
                            Text("\(day)")
                                .font(.callout)
                                .frame(width: 35,height:10)
                                .foregroundColor(.white)
                                .buttonStyle(buttonChoiceStyle(color: "Myblue"))
                        }
                    
                        
                        }
                }
            }
            */
            
            let dateHolding = "\(selectedDay)/\(selectedMonth)/\(selectedYear)"
            
        }
    }
}


func getDaysInMonth(month: Int, year: Int) -> Int? {
    let calendar = Calendar.current
    
    var startComps = DateComponents()
    startComps.day = 1
    startComps.month = month
    startComps.year = year
    
    var endComps = DateComponents()
    endComps.day = 1
    endComps.month = month == 12 ? 1 : month + 1
    endComps.year = month == 12 ? year + 1 : year
    
    
    let startDate = calendar.date(from: startComps)!
    let endDate = calendar.date(from:endComps)!
    
    
    let diff = calendar.dateComponents([Calendar.Component.day], from: startDate, to: endDate)
    
    return diff.day
}

#if DEBUG
struct Testing_ContentViewPreviews: PreviewProvider {
    static var previews: some View {
        Group {
            
            Testing_ContentView()
                .environment(\.colorScheme, .light)
                .previewDisplayName("Light Mode")
            
        }
    }
}
#endif

extension Formatter {
    static let yyyMMdd: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()
    
    static let monthMedium: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "LLL"
            return formatter
        }()
    
}


extension Date {
    var monthMedium: String  { return Formatter.monthMedium.string(from: self) }

}



extension String {
    var yyyMMddToDate: Date? {
        Formatter.yyyMMdd.date(from: self)
    }
}

