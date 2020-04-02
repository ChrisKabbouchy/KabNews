//
//  NewsData.swift
//  KabNews
//
//  Created by Christian Kabouchy on 3/26/20.
//  Copyright © 2020 Christian Kabouchy. All rights reserved.
//

import Foundation

struct NewsData : Decodable {
    
    var status : String?
    var totalResults : Int?
    var articles : [articlesData]?
}

struct articlesData : Decodable{
    
    var source : sourceData
    var author : String?
    var title : String?
    var description : String?
    var url : String?
    var urlToImage : String?
    var publishedAt : String?
    var content : String?
    
}

struct sourceData : Decodable {
    
    var id : String?
    var name : String?
}
