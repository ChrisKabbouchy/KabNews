//
//  NewsModel.swift
//  KabNews
//
//  Created by Christian Kabouchy on 3/26/20.
//  Copyright © 2020 Christian Kabouchy. All rights reserved.
//

import Foundation

struct NewsModel : Identifiable {
    
    var id : Int
    var sourceName : String
    var title : String
    var description : String
    var image :  URL
    var newsUrl : URL
    var date : String
    var author : String?
}
