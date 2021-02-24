//
//  HotTopicsView.swift
//  KabNews
//
//  Created by Christian Kabouchy on 4/10/20.
//  Copyright © 2020 Christian Kabouchy. All rights reserved.
//

import SwiftUI

struct HotTopicsView : View {
    @Environment(\.verticalSizeClass) var sizeClass
    @EnvironmentObject var newsManager : NewsManager
    @State var isPressed = false
    @State var newsID : Int = 0
    
    var body : some View{
        
        ScrollView(.horizontal, showsIndicators: false){
            HStack{
                //horizontal Scrollview for the hot topics view
                ForEach(self.newsManager.news) { newsItem in
                    Button {
                        self.newsID = newsItem.id ?? 0
                        self.isPressed.toggle()
                    } label: {
                        //MARK: -Portrait Mode
                        if sizeClass == .regular {
                            Text("-\(newsItem.title!)")
                                .bold()
                                .lineLimit(5)
                                .foregroundColor(Color.white)
                                .background(Rectangle()
                                                .frame( width: UIScreen.main.bounds.width, height:  UIScreen.main.bounds.height/5.5,alignment: .bottom)
                                                .foregroundColor(Color.black)
                                                .blur(radius: 2)
                                                .opacity(0.3))
                                .font(.headline)
                                .padding()
                                .frame(width: UIScreen.main.bounds.width/2,  height: UIScreen.main.bounds.height/3, alignment: .bottom)
                                .background(
                                    imageView(withURL: newsItem.imageUrl, currentNewsItem: self.newsManager.news[newsItem.id!])
                                        .aspectRatio(contentMode: .fill)
                                )
                                .cornerRadius(40)
                                .padding([.leading])
                                //Open the highlight view when the selected news is pressed
                                
                        }
                        //MARK: -Landscape Mode
                        else{
                            Text("-\(newsItem.title!)")
                                .bold()
                                .lineLimit(5)
                                .foregroundColor(Color.white)
                                .background(Rectangle()
                                                .frame( width: UIScreen.main.bounds.height, height:  UIScreen.main.bounds.width/5.5,alignment: .bottom)
                                                .foregroundColor(Color.black)
                                                .blur(radius: 2)
                                                .opacity(0.3))
                                .font(.headline)
                                .padding()
                                .frame(width: UIScreen.main.bounds.height/1.5,  height: UIScreen.main.bounds.width/4, alignment: .bottom)
                                .background(
                                    imageView(withURL: newsItem.imageUrl, currentNewsItem: self.newsManager.news[newsItem.id!])
                                        .aspectRatio(contentMode: .fill)
                                )
                                .cornerRadius(40)
                                .padding([.leading])
                                //Open the highlight view when the selected news is pressed
                                
                        }
                    }.sheet(isPresented: self.$isPressed){
                        HighlightView(newsCategory: self.newsManager.news, newsID: self.$newsID ).environmentObject(self.newsManager)
                    }
                    
                }
            }
        }
    }
}

struct HotTopicsView_Previews: PreviewProvider {
    static var previews: some View {
        HotTopicsView()
    }
}
