//
//  MainView.swift
//  KabNews
//
//  Created by Christian Kabouchy on 3/22/20.
//  Copyright © 2020 Christian Kabouchy. All rights reserved.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var newsManager = NewsManager()
    
    var body: some View {
        NavigationView{
            ZStack{
                GeometryReader{ geo in
                    Color("baseColor").edgesIgnoringSafeArea(.all)
                    
                    VStack(alignment: .leading){
                        TopView(buttonPressed: 0)
                            .padding([.bottom])
                        Text("Hot Topics")
                            .font(.system(.largeTitle, design: .rounded))
                            .bold()
                            .padding([.horizontal])
                        if self.newsManager.news.count>0{
                            
                            ScrollView(.horizontal, showsIndicators: false){
                                HStack{
                                    ForEach(self.newsManager.news) { newsItem in
                                        NavigationLink(destination: HighlightView()){
                                            Text("-\(newsItem.title!)")
                                                .bold().font(.headline)
                                                .frame(width: geo.size.width/2, height: geo.size.height/3, alignment: .bottom)
                                                .padding()
                                                .background(Image("christian")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill))
                                                .cornerRadius(40)
                                                .padding([.leading])
                                            
                                            }.buttonStyle(PlainButtonStyle())
                                            .navigationBarHidden(false)
                                            .navigationBarTitle("Kab News")
                                    }
                                }
                            }
                        }
                        
                    }
                }
            }
            
        }.onAppear {
            self.newsManager.fetchNewsData()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
