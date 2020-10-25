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
        imageLoader = ImageLoader()
        newsManager = currentNewsItem
        imageUrl = urlString
    }
    
    var body: some View{
        //Check if image was loaded
        if newsManager.image == nil{
            imageLoader.loadImage(urlString: imageUrl)
        }else{
            DispatchQueue.main.async {
                self.loadedAlready = true
            }
        }
        if loadedAlready {
            //check if image loaded already and return the image
            return Image(uiImage: newsManager.image!)
                .renderingMode(.original)
                .resizable()
        }
        else if imageLoader.dataIsValid == true && newsManager.image == nil{
            //check if the image data is valid and the image was never saved and return the image
            newsManager.image = UIImage(data: imageLoader.data!)
            if newsManager.image == nil{
                //Check if the image is unable to save properly and save a placeholder image instead
                newsManager.image = UIImage(systemName: "exclamationmark.icloud")
            }
            return Image(uiImage: newsManager.image!)
                .renderingMode(.original)
                .resizable()
        }
        else{
            //return a placeholder image if the image data is invalid
            return Image(uiImage: UIImage(systemName: "photo.fill")!)
                .renderingMode(.original)
                .resizable()
        }
        
    }
}

