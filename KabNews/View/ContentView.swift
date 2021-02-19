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
        //Check user if logged in and display appropriate UI
        VStack{
            if isLoggedIn{
                //AnyView(SettingView().environmentObject(newsManager))
                
                MainView().environmentObject(newsManager)
            }
            else{
                LogInView()
            }
        }.onAppear(){
            //Notify to update the UI 
            NotificationCenter.default.addObserver(forName: NSNotification.Name("statusChange"), object: nil, queue: .main) { (_) in
                DispatchQueue.main.async {
                    self.isLoggedIn = UserDefaults.standard.bool(forKey: "logged-in")
                }
                
            }
        }
    }
}

struct contentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
