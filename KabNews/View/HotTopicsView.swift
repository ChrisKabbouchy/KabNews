//
//  HotTopicsView.swift
//  KabNews
//
//  Created by Christian Kabouchy on 4/10/20.
//  Copyright © 2020 Christian Kabouchy. All rights reserved.
//

import SwiftUI

struct HotTopicsView : View {
    @EnvironmentObject var newsManager : NewsManager
    @State var isPressed = false
    @State var newsID : Int?
    
    var body : some View{
        
        ScrollView(.horizontal, showsIndicators: false){
            HStack{
                ForEach(self.newsManager.news) { newsItem in
                    Button( action: {self.isPressed.toggle();self.newsID = newsItem.id}){
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
                    }
                    .sheet(isPresented: self.$isPressed){
                        HighlightView(newsCategory: self.newsManager.news, newsID: self.newsID!).environmentObject(self.newsManager)
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
