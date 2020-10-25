//
//  ContentView.swift
//  KabNews
//
//  Created by Christian Kabouchy on 3/22/20.
//  Copyright © 2020 Christian Kabouchy. All rights reserved.
//

import SwiftUI

struct TopView: View {
    
    @EnvironmentObject var newsManager : NewsManager
    @State var buttonPressed = 0
    @State var isPressed = false
    @State var searchIsShowing =  false
    @State var searchField = ""
    @State var gearIsPressed = false
    @State var userGivenName = UserDefaults.standard.string(forKey: "user-name")
    
    var body: some View {
        NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
        return VStack{
            HStack{
                //IMAGE
                Image("appstore")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .aspectRatio(contentMode: .fit)
                VStack(alignment: .leading){
                    //NAME
                    Text(userGivenName ?? "No Name")
                        .fontWeight(.heavy)
                    Text("Premium User")
                        .font(.footnote)
                }.onAppear(){
                    NotificationCenter.default.addObserver(forName: NSNotification.Name("statusChange"), object: nil, queue: .main) { (_) in
                        DispatchQueue.main.async {
                            self.userGivenName = UserDefaults.standard.string(forKey: "user-name")
                        }
                        
                    }
                }
                Spacer()
                //SEARCH BUTTON
                Button (action: {self.searchIsShowing.toggle()}) {
                    Image(systemName: "magnifyingglass").foregroundColor(Color("textColor"))
                }.padding(.horizontal)
                //SETTINGS BUTTON
                Button(action: {self.gearIsPressed.toggle()}){
                    Image(systemName: "gear").foregroundColor(Color("textColor"))
                }.sheet(isPresented: $gearIsPressed){
                    SettingView().environmentObject(self.newsManager)
                }
            }.padding([.horizontal])
            //SEARCH FIELD
            if self.searchIsShowing {
                HStack {
                    TextField("Search for News", text: self.$searchField)
                        .padding()
                    Button(action: {
                        if self.searchField != "" {
                            self.newsManager.fetchLatestNews(with: self.searchField, isSearchResult: true)
                        }
                    }){
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Color("textColor"))
                            .padding(.horizontal)
                    }
                }
                .frame(width: UIScreen.main.bounds.width - 80,height: 40 )
                .overlay(RoundedRectangle(cornerRadius: 10)
                .stroke(Color("secondColor"), lineWidth: 4))
                .padding(.bottom)
                .padding(.top)
            }
            //CATEGORY BUTTONS
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    Button (action: {
                        self.buttonPressed = 1 ; self.isPressed=true
                        self.newsManager.fetchLatestNews(with: "technology", isSearchResult: false)
                        
                    } ) {
                        if self.buttonPressed == 1 {
                            Text("Tech")
                                .fontWeight(.heavy)
                                .foregroundColor(Color("secondColor"))
                        }
                        else{
                            Text("Tech")
                                .fontWeight(.heavy)
                                .foregroundColor(Color("textColor"))
                        }
                    }
                    Spacer()
                    Button (action: {
                        self.buttonPressed = 2
                        self.newsManager.fetchLatestNews(with: "business", isSearchResult: false)
                        
                    }) {
                        if self.buttonPressed == 2 {
                            Text("Business")
                                .fontWeight(.heavy)
                                .foregroundColor(Color("secondColor"))
                        }
                        else{
                            Text("Business")
                                .fontWeight(.heavy)
                                .foregroundColor(Color("textColor"))
                        }
                    }
                    Spacer()
                    Button (action: {
                        self.buttonPressed = 3
                        self.newsManager.fetchLatestNews(with: "entertainment", isSearchResult: false)
                    }) {
                        if self.buttonPressed == 3 {
                            Text("Entertainment")
                                .fontWeight(.heavy)
                                .foregroundColor(Color("secondColor"))
                        }
                        else{
                            Text("Entertainment")
                                .fontWeight(.heavy)
                                .foregroundColor(Color("textColor"))
                        }
                    }
                    Spacer()
                    Button (action: {
                        self.buttonPressed = 4
                        self.newsManager.fetchLatestNews(with: "health", isSearchResult: false)
                    }) {
                        if self.buttonPressed == 4 {
                            Text("Health")
                                .fontWeight(.heavy)
                                .foregroundColor(Color("secondColor"))
                        }
                        else{
                            Text("Health")
                                .fontWeight(.heavy)
                                .foregroundColor(Color("textColor"))
                        }
                    }
                    Button (action: {
                        self.buttonPressed = 6
                        self.newsManager.fetchLatestNews(with: "science", isSearchResult: false)
                    }) {
                        if self.buttonPressed == 6 {
                            Text("Science")
                                .fontWeight(.heavy)
                                .foregroundColor(Color("secondColor"))
                        }
                        else{
                            Text("Science")
                                .fontWeight(.heavy)
                                .foregroundColor(Color("textColor"))
                        }
                    }
                    Spacer()
                    Button (action: {
                        self.buttonPressed = 5
                        self.newsManager.fetchLatestNews(with: "sports", isSearchResult: false)
                    }) {
                        if self.buttonPressed == 5 {
                            Text("Sports")
                                .fontWeight(.heavy)
                                .foregroundColor(Color("secondColor"))
                        }
                        else{
                            Text("Sports")
                                .fontWeight(.heavy)
                                .foregroundColor(Color("textColor"))
                        }
                    }
                }.padding([.horizontal])
            }
        }.onAppear(){
            self.buttonPressed = 1
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TopView()
    }
}
