//
//  testing.swift
//  Clarity Therapy
//
//  Created by Nawaf Almutairi on 31/03/2022.
//

import Foundation
import SwiftUI

struct ProgressRing_ContentView: View {

@State var progressToggle = false
@State var progressRingEndingValue: CGFloat = 0.75

var ringColor: Color = Color.green
var ringWidth: CGFloat = 20
var ringSize: CGFloat = 200

var body: some View {
    TabView{
        NavigationView{
            VStack{

                Spacer()

                ZStack{
                    Circle()
                        .trim(from: 0, to: progressToggle ? progressRingEndingValue : 0)
                        .stroke(ringColor, style: StrokeStyle(lineWidth: ringWidth, lineCap: .round, lineJoin: .round))
                        .background(Circle().stroke(ringColor, lineWidth: ringWidth).opacity(0.2))
                        .frame(width: ringSize, height: ringSize)
                        .rotationEffect(.degrees(-90.0))
                        .animation(.easeInOut(duration: 1))
                        .onAppear() {
                            self.progressToggle.toggle()
                        }

                    Text("\(Int(progressRingEndingValue * 100)) %")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }

                Spacer()

                Button(action: {
                    self.progressRingEndingValue = CGFloat.random(in: 0...1)
                }) { Text("Randomize")
                        .font(.largeTitle)
                        .foregroundColor(ringColor)
                }

                Spacer()

            }
            .navigationBarTitle("ProgressRing", displayMode: .inline)
            .navigationBarItems(leading:
                Button(action: {
                    print("Refresh Button Tapped")
                    }) {
                    Image(systemName: "arrow.clockwise")
                        .foregroundColor(Color.green)
                    }, trailing:
                Button(action: {
                    print("Share Button Tapped")
                    }) {
                    Image(systemName: "square.and.arrow.up")
                        .foregroundColor(Color.green)
                }
            )
        }
    }
}
}

#if DEBUG
struct ProgressRing_ContentView_Previews: PreviewProvider {
static var previews: some View {
    Group {

        ProgressRing_ContentView()
            .environment(\.colorScheme, .light)
            .previewDisplayName("Light Mode")

}
}
}
#endif
