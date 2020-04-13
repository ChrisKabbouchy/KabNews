//
//  MainView.swift
//  KabNews
//
//  Created by Christian Kabouchy on 3/22/20.
//  Copyright © 2020 Christian Kabouchy. All rights reserved.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var newsManager : NewsManager
    
    var body: some View {
        ZStack(alignment: .top){
            Color("baseColor").edgesIgnoringSafeArea(.all)
            ScrollView{
                VStack(alignment: .leading){
                    TopView(buttonPressed: 0)
                    //.padding([.bottom])
                    Text("Hot Topics")
                        .font(.system(.largeTitle, design: .rounded))
                        .bold()
                        .padding([.horizontal])
                    if self.newsManager.news.count>0{
                        HotTopicsView()
                            .environmentObject(self.newsManager)
                        Text("Latest News")
                            .font(.system(.largeTitle, design: .rounded))
                            .bold()
                            .padding([.horizontal])
                        LatestNewsView().environmentObject(self.newsManager)
                    }
                }
            }
            
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
        }
        else if imageLoader.dataIsValid == true && newsManager.image == nil{
            newsManager.image = UIImage(data: imageLoader.data!)
            if newsManager.image == nil{
                newsManager.image = UIImage(systemName: "exclamationmark.icloud")
            }
            return Image(uiImage: newsManager.image!)
                .renderingMode(.original)
                .resizable()
        }
        else{
            return Image(uiImage: UIImage(systemName: "photo.fill")!)
                .renderingMode(.original)
                .resizable()
        }
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
