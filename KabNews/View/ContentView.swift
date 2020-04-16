//
//  contentView.swift
//  KabNews
//
//  Created by Christian Kabouchy on 4/5/20.
//  Copyright © 2020 Christian Kabouchy. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var newsManager : NewsManager
    @State var isLoggedIn : Bool = UserDefaults.standard.bool(forKey: "logged-in")
    var body: some View {
        VStack{
            
            if isLoggedIn{
                
                MainView().environmentObject(newsManager)
            }
            else{
                
                LogInView()
            }
            
        }
            .onAppear(){
                NotificationCenter.default.addObserver(forName: NSNotification.Name("statusChange"), object: nil, queue: .main) { (_) in
                    self.isLoggedIn = UserDefaults.standard.bool(forKey: "logged-in")
                }
        }
    }
}

struct contentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
