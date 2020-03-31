//
//  NewsManager.swift
//  KabNews
//
//  Created by Christian Kabouchy on 3/26/20.
//  Copyright © 2020 Christian Kabouchy. All rights reserved.
//

import SwiftUI

class NewsManager : ObservableObject{
    
    @Published var news = [NewsModel]()
    
    func fetchNewsData () {
        
        let baseUrl = "https://newsapi.org/v2/top-headlines?country=us"
        //&category=politics"
        let apiKey = "fcf0aefb55a24e739bbb8ea0b5edbad1"
        let finalUrl = "\(baseUrl)&apiKey=\(apiKey)"
        print(finalUrl)
        
        let url = URL(string: finalUrl)
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        let session = URLSession(configuration: .default)
        
        let task =  session.dataTask(with: request) { (data, responce, error) in
            if error != nil{
                return
            }
            if let safeData = data{
                let decoder = JSONDecoder()
                do {
                    let decodedData = try decoder.decode(NewsData.self, from: safeData)
                    for i in 0..<decodedData.articles.count{
                        let currentItem = decodedData.articles[i]
                       let newNewsItem  = NewsModel(id: i, sourceName: currentItem.source.name, title: currentItem.title, description: currentItem.description, imageUrl: currentItem.urlToImage, newsUrl: currentItem.url, date: currentItem.publishedAt, author: currentItem.author,content: currentItem.content)
                        DispatchQueue.main.async {
                            self.news.append(newNewsItem)
                        }
                        
                    }
                } catch  {
                    print(error)
                }
            }
        }
        task.resume()
        
        
    }
}
