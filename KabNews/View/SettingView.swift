//
//  SettingView.swift
//  KabNews
//
//  Created by Christian Kabouchy on 4/9/20.
//  Copyright © 2020 Christian Kabouchy. All rights reserved.
//

import SwiftUI

struct SettingView: View {
    var body: some View {
        ZStack {
            Color("baseColor")
            .edgesIgnoringSafeArea(.all)
            VStack{
                ZStack(alignment:.leading){
                    Color("baseColor")
                    VStack(alignment:.leading) {
                        Text("Settings")
                            .font(.largeTitle)
                            .bold()
                            .padding()
                        Text("Settings")
                            .font(.largeTitle)
                            .bold()
                            .padding()
                    }
                }
                    Button(action: {}){
                        Text("LogOut")
                            .bold()
                            .padding(.horizontal)
                            .frame(width: UIScreen.main.bounds.width - 100,height: 50 ,alignment: .center)
                            .foregroundColor(Color.white)
                            .background(Color("secondColor"))
                            .cornerRadius(10)
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
