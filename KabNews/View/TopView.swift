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
                Button (action: {}) {
                    Image(systemName: "magnifyingglass").foregroundColor(Color("textColor"))
                }.padding(.horizontal)
                Button(action: {}){
                    Image(systemName: "gear").foregroundColor(Color("textColor"))
                }
            }.padding()
            
            HStack{
                Button (action: {self.buttonPressed = 1 ; self.isPressed=true} ) {
                    if buttonPressed == 1 {
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
                    if buttonPressed == 2 {
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
                    if buttonPressed == 3 {
                        Text("Politics")
                            .fontWeight(.heavy)
                            .foregroundColor(Color("secondColor"))
                    }
                    else{
                        Text("Politics")
                            .fontWeight(.heavy)
                            .foregroundColor(Color("textColor"))
                    }
                }
                Spacer()
                Button (action: {self.buttonPressed = 4}) {
                    if buttonPressed == 4 {
                        Text("World")
                            .fontWeight(.heavy)
                            .foregroundColor(Color("secondColor"))
                    }
                    else{
                        Text("World")
                            .fontWeight(.heavy)
                            .foregroundColor(Color("textColor"))
                    }
                }
                Spacer()
                Button (action: {self.buttonPressed = 5}) {
                    if buttonPressed == 5 {
                        Text("Design")
                            .fontWeight(.heavy)
                            .foregroundColor(Color("secondColor"))
                    }
                    else{
                        Text("Design")
                            .fontWeight(.heavy)
                            .foregroundColor(Color("textColor"))
                    }
                }
            }.padding([.horizontal])
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TopView()
    }
}
