//
//  Styles.swift
//  Clarity Therapy
//
//  Created by Nawaf Almutairi on 19/02/2022.
//

import Foundation
import SwiftUI

extension UINavigationController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        let appearance = UINavigationBarAppearance()
        //background color of the navigation and status bar
        appearance.backgroundColor = UIColor(named: "Mywhite")
        
//        //color when the title is large
        appearance.largeTitleTextAttributes.updateValue(UIColor(named: "Myblue")!, forKey: NSAttributedString.Key.foregroundColor)
//
//        //color when the title is small
       appearance.titleTextAttributes.updateValue(UIColor(named: "Mywhite")!, forKey: NSAttributedString.Key.foregroundColor)

        
        // change the background- and title foregroundcolor for navigationbar
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.compactAppearance = appearance
        // change color of navigationbar items
        navigationBar.tintColor = UIColor(named: "Myblue")
        //UINavigationBar.appearance().tintColor = .white

    }
}

struct buttonChoiceStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color("Myblue"))
            .cornerRadius(10)
            .shadow(color: Color("shadow"), radius: 3, x: 0.5, y: 0.5)
        
    }
}

//MARK: - Tab bar view appearance
extension TabBarView {
  func setupTabBar() {
    UITabBar.appearance().barTintColor = UIColor(named: "Mywhite")
    UITabBar.appearance().tintColor  = UIColor(named: "Myblue")
    //UITabBar.appearance().unselectedItemTintColor =  UIColor(.white.opacity(0.5))
    
   
  }
}



extension View {
    func buttonStyle<Style: ViewModifier>(_ style: Style) -> some View {
        ModifiedContent(content: self, modifier: style)
    }
}
