//
//  HighlightView.swift
//  KabNews
//
//  Created by Christian Kabouchy on 3/22/20.
//  Copyright © 2020 Christian Kabouchy. All rights reserved.
//

import SwiftUI
import Firebase
import GoogleSignIn

struct HighlightView: View {
    
    var body: some View {
        GeometryReader{ geo in
            ZStack{
                Color("baseColor")
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    Image("christian")
                        .resizable()
                        .edgesIgnoringSafeArea(.all).frame( height: geo.size.height/3,alignment: .top)
                    ZStack (alignment: .topLeading) {
                        Color("baseColor")
                            .edgesIgnoringSafeArea(.all).frame( height: geo.size.height/1.5,alignment: .top)
                        VStack(alignment:.center) {
                            VStack (alignment: .leading) {
                                Text("Source")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                Text("author")
                                    .font(.headline)
                                .fontWeight(.bold)
                                Text("Date")
                                    .font(.caption)
                                    .fontWeight(.bold)
                                Divider()
                                    .padding()
                                Text("title")
                                .font(.caption)
                                .fontWeight(.bold)
                                Text("the news")
                                .font(.caption)
                                .fontWeight(.bold)
                                Spacer()
                                
                            }.padding()
                            Button(action: {}){
                                Text("Read full article")
                                .bold()
                                .padding()
                                .frame(width: geo.size.width - 100,height: 50 ,alignment: .center)
                                .foregroundColor(Color.white)
                                .background(Color("secondColor"))
                                .cornerRadius(10)
                            }
                        }
                        
                        
                    }
                    
                }
            }
        }
    }
}
struct HighlightView_Previews: PreviewProvider {
    static var previews: some View {
        HighlightView().environment(\.colorScheme, .dark)
    }
}
