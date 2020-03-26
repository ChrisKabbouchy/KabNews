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
    init() {
        newsManager.fetchNewsData()
    }
    
    var body: some View {
        ZStack{
            Color("baseColor").edgesIgnoringSafeArea(.all)
            VStack{
                TopView(buttonPressed: 0)
                if newsManager.news.count>0{
                    Text("\(newsManager.news[0].description)")
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
