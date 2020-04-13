//
//  ContentView.swift
//  KabNews
//
//  Created by Christian Kabouchy on 3/22/20.
//  Copyright © 2020 Christian Kabouchy. All rights reserved.
//

import SwiftUI

struct TopView: View {
    
    @State var buttonPressed = 0
    @State var isPressed = false
    @State var searchIsShowing =  false
    @State var searchField = ""
    @State var gearIsPressed = false
    
    var body: some View {
        
        VStack{
            HStack{
                Image("christian")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .aspectRatio(contentMode: .fit)
                VStack(alignment: .leading){
                    Text("Christian kabbouchy")
                        .fontWeight(.heavy)
                    Text("Premium User")
                        .font(.footnote)
                }
                Spacer()
                Button (action: {self.searchIsShowing.toggle()}) {
                    Image(systemName: "magnifyingglass").foregroundColor(Color("textColor"))
                }.padding(.horizontal)
                Button(action: {self.gearIsPressed.toggle()}){
                    Image(systemName: "gear").foregroundColor(Color("textColor"))
                }.sheet(isPresented: $gearIsPressed){
                    SettingView()
                }
            }.padding([.horizontal])
            if self.searchIsShowing {
                HStack {
                    TextField("Search for News", text: self.$searchField)
                        .padding()
                    Button(action: {}){
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Color("textColor"))
                            .padding(.horizontal)
                    }
                }
                .frame(width: UIScreen.main.bounds.width - 80,height: 40 )
                .overlay(RoundedRectangle(cornerRadius: 10)
                .stroke(Color("secondColor"), lineWidth: 4))
                .padding(.bottom)
            }
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    Button (action: {self.buttonPressed = 1 ; self.isPressed=true} ) {
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
                    Button (action: {self.buttonPressed = 2}) {
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
                    Button (action: {self.buttonPressed = 3}) {
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
                    Button (action: {self.buttonPressed = 4}) {
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
                    Button (action: {self.buttonPressed = 6}) {
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
                    Button (action: {self.buttonPressed = 5}) {
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
