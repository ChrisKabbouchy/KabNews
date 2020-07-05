//
//  SettingView.swift
//  KabNews
//
//  Created by Christian Kabouchy on 4/9/20.
//  Copyright © 2020 Christian Kabouchy. All rights reserved.
//

import SwiftUI
import Firebase

struct SettingView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var newsManager : NewsManager
    @State var selectedCountry = UserDefaults.standard.integer(forKey: "country-selected")
    @State var name : String = ""
    @State var countries = ["🇦🇷Argentina","🇦🇹Austria","🇦🇺Australia","🇧🇪Belgium","🇧🇷Brazil","🇧🇬Bulgaria","🇨🇦Canada","🇨🇳China"
        ,"🇨🇴Colombia","🇨🇺Cuba","🇨🇿Czech Republic","🇪🇬Egypt","🇫🇷France","🇩🇪Germany","🇬🇷Greece","🇭🇰Hong Kong","🇭🇺Hungary","🇮🇳India","🇮🇩Indonesia","🇮🇪Ireland","🇮🇹Italy","🇯🇵Japan","🇱🇻Latvia"]
    var body: some View {
        NavigationView {
            ZStack {
                VStack{
                    ZStack(alignment:.leading){
                        VStack(alignment:.leading) {
                            Form{
                                Picker(selection: $selectedCountry, label: Text("Country")){
                                    ForEach(0..<countries.count){
                                        Text(self.countries[$0]).tag($0)
                                    }
                                }
                                HStack{
                                    Text("Your Name").padding(.trailing)
                                    TextField("Name", text: self.$name).padding(.leading)
                                }
                                
                            }.padding(.vertical)
                            
                        }
                        .navigationBarTitle("Settings")
                    }
                    
                    Button(action: {
                        UserDefaults.standard.set(self.selectedCountry, forKey: "country-selected")
                        self.newsManager.fetchNewsData()
                        self.newsManager.fetchLatestNews(with: "technology", isSearchResult: false)
                        self.presentationMode.wrappedValue.dismiss()
                    }){
                        Text("Save")
                            .bold()
                            .padding()
                            .frame(width: UIScreen.main.bounds.width - 100,height: 50 ,alignment: .center)
                            .foregroundColor(Color.white)
                            .background(Color("secondColor"))
                            .cornerRadius(10)
                    }
                    Spacer()
                    Button(action: {
                        let firebaseAuth = Auth.auth()
                        do {
                            try firebaseAuth.signOut()
                            self.presentationMode.wrappedValue.dismiss()
                            UserDefaults.standard.set(false, forKey: "logged-in")
                        } catch let signOutError as NSError {
                            print ("Error signing out: %@", signOutError)
                            UserDefaults.standard.set(true, forKey: "logged-in")
                        }
                        
                    }){
                        Text("LogOut")
                            .bold()
                            .padding()
                            .frame(width: UIScreen.main.bounds.width - 100,height: 50 ,alignment: .center)
                            .foregroundColor(Color.white)
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                }
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView().environment(\.colorScheme, .dark)
    }
}
