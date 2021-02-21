//
//  MainView.swift
//  KabNews
//
//  Created by Christian Kabouchy on 3/22/20.
//  Copyright © 2020 Christian Kabouchy. All rights reserved.
//

import SwiftUI

struct MainView: View {
    
    @Environment(\.verticalSizeClass) var sizeClass
    @EnvironmentObject var newsManager : NewsManager
    
    var body: some View {
        ZStack(alignment: .top){
            Color("baseColor").edgesIgnoringSafeArea(.all)
            ScrollView{
                VStack(alignment: .leading){
                    //Top view
                    TopView(buttonPressed: 0)
                    Text("Hot Topics")
                        .font(.system(.largeTitle, design: .rounded))
                        .bold()
                        .padding([.horizontal])
                    if self.newsManager.news.count>0{
                        //Hot topics view
                        HotTopicsView()
                            .environmentObject(self.newsManager)
                        Text("Latest News")
                            .font(.system(.largeTitle, design: .rounded))
                            .bold()
                            .padding([.horizontal])
                        //Latest news view
                        LatestNewsView().environmentObject(self.newsManager)
                    }
                }
            }
            
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
