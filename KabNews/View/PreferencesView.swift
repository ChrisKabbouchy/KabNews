//
//  PreferancesView.swift
//  KabNews
//
//  Created by Christian Kabouchy on 15/02/2021.
//  Copyright © 2021 Christian Kabouchy. All rights reserved.
//

import SwiftUI

struct PreferencesView: View {
    init(){
            UITableView.appearance().backgroundColor = .clear
        }
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var newsManager : NewsManager
    @State var selectedCountry = 0
    @State var name : String = UserDefaults.standard.string(forKey: "user-name") ?? ""
    @State var countries = ["🇦🇷Argentina","🇦🇹Austria","🇦🇺Australia","🇧🇪Belgium","🇧🇷Brazil","🇧🇬Bulgaria","🇨🇦Canada","🇨🇳China"
                            ,"🇨🇴Colombia","🇨🇺Cuba","🇨🇿Czech Republic","🇪🇬Egypt","🇫🇷France","🇩🇪Germany","🇬🇷Greece","🇭🇰Hong Kong","🇭🇺Hungary","🇮🇳India","🇮🇩Indonesia","🇮🇪Ireland","🇮🇹Italy","🇯🇵Japan","🇱🇻Latvia","🇱🇹Lithuania","🇲🇾Malaysia","🇲🇽Mexico","🇲🇦Morocco","🇳🇱Netherlands","🇳🇿New Zealand","🇳🇬Nigeria","🇳🇴Norway","🇵🇭Philippines","🇵🇱Poland","🇵🇹Portugal","🇷🇴Romania","🇷🇺Russia","🇸🇦Saudi Arabia","🇷🇸Serbia","🇸🇬Singapore","🇸🇰Slovakia","🇸🇮Slovenia","🇿🇦South Africa","🇰🇷South Korea","🇸🇪Sweden","🇨🇭Switzerland","🇹🇼Taiwan","🇹🇭Thailand","🇹🇷Turkey","🇦🇪United Arab Emirates","🇺🇦Ukraine","🇬🇧United Kingdom","🇺🇸United States","🇻🇪Venezuela"]
    
    var body: some View {
            ZStack {
                Color("baseColor")
                    .edgesIgnoringSafeArea(.all)
                VStack(alignment: .center) {
                    Text("Welcome")
                        .font(.largeTitle)
                        .bold()
                    Form{
                        //COUNTRY PICKER
                        Picker(selection: $selectedCountry, label: Text("Country")){
                            ForEach(0..<countries.count){
                                Text(self.countries[$0]).tag($0)
                            }
                        }
                        //NAME FIELD
                        HStack{
                            Text("Your Name").padding(.trailing)
                            TextField("Name", text: self.$name).padding(.leading)
                        }
                        
                    }.padding(.vertical)
                    .background(Color("baseColor"))
                    //NEXT BUTTON
                    Button(action: {
                        UserDefaults.standard.set(self.selectedCountry, forKey: "country-selected")
                        UserDefaults.standard.set(self.name, forKey: "user-name")
                        UserDefaults.standard.set(true, forKey: "logged-in")
                        NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
                    }, label: {
                        Text("Next")
                            .bold()
                            .padding()
                            .frame(width: UIScreen.main.bounds.width - 100,height: 50 ,alignment: .center)
                            .foregroundColor(Color.white)
                            .background(Color("secondColor"))
                            .cornerRadius(10)
                            .padding(.bottom)
                    })
                    
                }.onAppear(){
                    //Notify to update the UI
                    NotificationCenter.default.addObserver(forName: NSNotification.Name("statusChange"), object: nil, queue: .main) { (_) in
                        DispatchQueue.main.async {
                            self.name = UserDefaults.standard.string(forKey: "user-name") ?? ""
                        }
                        
                    }
                }

            }
    }
}

struct PreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PreferencesView()
        }
    }
}
