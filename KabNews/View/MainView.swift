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
    @State var isPressed = false
    
    var body: some View {
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
                                    Button( action: {self.isPressed = true}){
                                        Text("-\(newsItem.title!)")
                                            .bold()
                                            .foregroundColor(Color.white)
                                            .font(.headline)
                                            .frame(width: geo.size.width/2, height: geo.size.height/3, alignment: .bottom)
                                            .padding()
                                            .background(
                                                imageView(withURL: newsItem.imageUrl, currentNewsItem: self.newsManager.news[newsItem.id!])
                                        ) .cornerRadius(40)
                                            .padding([.leading])
                                    }
                                    .sheet(isPresented: self.$isPressed){
                                        //HighlightView(newsManager: self.newsManager, email: "",password: "")
                                        LogInView()
                                        
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


struct imageView: View {
    
    @ObservedObject var imageLoader : ImageLoader
    var newsManager : NewsModel
    var imageUrl : String?
    @State var loadedAlready = false
    
    init(withURL urlString:String?, currentNewsItem:NewsModel) {
        imageLoader = ImageLoader()
        newsManager = currentNewsItem
        imageUrl = urlString
    }
    
    var body: some View{
        
        if newsManager.image == nil{
            imageLoader.loadImage(urlString: imageUrl)
        }else{
            DispatchQueue.main.async {
                self.loadedAlready = true
            }
            
        }
        if loadedAlready {
            return Image(uiImage: newsManager.image!)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fill)
        }
        else if imageLoader.dataIsValid == true && newsManager.image == nil{
            newsManager.image = UIImage(data: imageLoader.data!)
            return Image(uiImage: newsManager.image!)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fill)
        }
        else{
            return Image(uiImage: UIImage(systemName: "photo.fill")!)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fill)
        }
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
