//
//  ImageView.swift
//  KabNews
//
//  Created by Christian Kabouchy on 10/25/20.
//  Copyright © 2020 Christian Kabouchy. All rights reserved.
//

import SwiftUI

struct imageView: View {
    
    @ObservedObject var imageLoader : ImageLoader
    var newsManager : NewsModel
    var imageUrl : String?
    @State var loadedAlready = false
    
    init(withURL urlString:String?, currentNewsItem:NewsModel) {
        imageLoader = ImageLoader(imageString: urlString)
        newsManager = currentNewsItem
        imageUrl = urlString
    }
    
    var body: some View{
        Image(uiImage: imageLoader.image)
                    .renderingMode(.original)
                    .resizable()
    }
}

