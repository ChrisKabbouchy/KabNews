//
//  LatestNewsView.swift
//  KabNews
//
//  Created by Christian Kabouchy on 4/13/20.
//  Copyright © 2020 Christian Kabouchy. All rights reserved.
//

import SwiftUI

struct LatestNewsView: View {
    @Environment(\.verticalSizeClass) var sizeClass
    @EnvironmentObject var newsManager : NewsManager
    @State var isPressed = false
    @State var newsID : Int = 0
    
    var body: some View {
        
        VStack(alignment:.leading){
            //Vertical scrollview for the latest news
            ForEach(self.newsManager.latestNews) { newsItem in
                HStack{
                    Button {
                        self.isPressed.toggle()
                        self.newsID = newsItem.id ?? 0
                    } label: {
                        //MARK: -Portrait Mode
                        if sizeClass == .regular {
                            imageView(withURL: newsItem.imageUrl, currentNewsItem: self.newsManager.latestNews[newsItem.id!])
                                .frame(width: UIScreen.main.bounds.width/3, height: UIScreen.main.bounds.height/6)
                                .aspectRatio(contentMode: .fit)
                                .padding(.leading)
                            Text("-\(newsItem.title!)")
                                .bold()
                                .padding(.trailing)
                                
                                //open the selected news when pressed
                                .sheet(isPresented: self.$isPressed){
                                    HighlightView(newsCategory: self.newsManager.latestNews, newsID: self.$newsID ).environmentObject(self.newsManager)
                                }
                        }
                        //MARK: -Landscape Mode
                        else{
                            imageView(withURL: newsItem.imageUrl, currentNewsItem: self.newsManager.latestNews[newsItem.id!])
                                .frame(width: UIScreen.main.bounds.height/1.5, height: UIScreen.main.bounds.width/5)
                                .aspectRatio(contentMode: .fit)
                                .padding(.leading)
                            Text("-\(newsItem.title!)")
                                .bold()
                                .padding(.trailing)
                                
                                //open the selected news when pressed
                                .sheet(isPresented: self.$isPressed){
                                    HighlightView(newsCategory: self.newsManager.latestNews, newsID: self.$newsID ).environmentObject(self.newsManager)
                                }
                        }
                    }.buttonStyle(PlainButtonStyle())
                }
            }
        }
    }
}

struct LatestNewsView_Previews: PreviewProvider {
    static var previews: some View {
        LatestNewsView()
    }
}
