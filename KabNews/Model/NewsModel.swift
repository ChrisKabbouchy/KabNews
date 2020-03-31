//
//  NewsModel.swift
//  KabNews
//
//  Created by Christian Kabouchy on 3/26/20.
//  Copyright © 2020 Christian Kabouchy. All rights reserved.
//

import UIKit

class NewsModel : Identifiable {
    
    var id : Int?
    var sourceName : String?
    var title : String?
    var description : String?
    var imageUrl :  URL?
    var image : UIImage?
    var newsUrl : URL?
    var date : String?
    var author : String?
    var content : String?
    
    init(id:Int?,sourceName:String?,title:String?,description:String?,imageUrl:URL?,newsUrl:URL?,date:String?,author:String?,content:String?) {
        
        self.id=id
        self.author=author
        self.content=content
        self.sourceName=sourceName
        self.title=title
        self.description=description
        self.imageUrl=imageUrl
        self.newsUrl=newsUrl
        self.date=date
        self.content=content
        
    }
}
