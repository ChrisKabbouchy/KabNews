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
    @Published var latestNews = [NewsModel]()
    
    var country : String {
        let selectedCountry = UserDefaults.standard.integer(forKey: "country-selected")
        switch selectedCountry {
        case 0:
            return "ar"
        case 1 :
            return "au"
        case 2 :
            return "at"
        case 3 :
            return "be"
        case 4 :
            return "br"
        case 5 :
            return "bg"
        case 6 :
            return "ca"
        case 7 :
            return "cn"
        case 8 :
            return "co"
        case 9 :
            return "cu"
        case 10 :
            return "cz"
        case 11 :
            return "eg"
        case 12 :
            return "fr"
        case 13 :
            return "de"
        case 14 :
            return "gr"
        default:
            return "us"
        }
    }
    private let baseUrl = "https://newsapi.org/v2/top-headlines?country="
    private let searchUrl = "https://newsapi.org/v2/everything?q="
    private let apiKey = "fcf0aefb55a24e739bbb8ea0b5edbad1"
    
    func fetchLatestNews(with category:String , isSearchResult:Bool){
        if !latestNews.isEmpty {
            latestNews.removeAll()
        }
        var finalUrl = ""
        if !isSearchResult {
            finalUrl = "\(baseUrl)\(country)&category=\(category)&apiKey=\(apiKey)"
            print(finalUrl)
        }
        else{
            finalUrl = "\(searchUrl)\(category)&apiKey=\(apiKey)"
        }
        let url = URL(string: finalUrl)
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        let session = URLSession(configuration: .default)
        
        let task =  session.dataTask(with: request) { (data, response, error) in
            if error != nil{
                return
            }
            if let safeData = data{
                let decoder = JSONDecoder()
                do {
                    let decodedData = try decoder.decode(NewsData.self, from: safeData)
                    for i in 0..<decodedData.articles!.count{
                        let currentItem = decodedData.articles![i]
                        let newNewsItem  = NewsModel(id: i, sourceName: currentItem.source.name, title: currentItem.title, description: currentItem.description, imageUrl: currentItem.urlToImage, newsUrl: currentItem.url, date: currentItem.publishedAt, author: currentItem.author,content: currentItem.content)
                        DispatchQueue.main.async {
                            self.latestNews.append(newNewsItem)
                        }
                        
                    }
                } catch  {
                    print(error)
                }
            }
        }
        task.resume()
        
        
    }
    
    
    func fetchNewsData () {
        if !news.isEmpty {
            news.removeAll()
        }
        let finalUrl = "\(baseUrl)\(country)&apiKey=\(apiKey)"
        print(finalUrl)
        
        let url = URL(string: finalUrl)
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        let session = URLSession(configuration: .default)
        
        let task =  session.dataTask(with: request) { (data, response, error) in
            if error != nil{
                return
            }
            if let safeData = data{
                let decoder = JSONDecoder()
                do {
                    let decodedData = try decoder.decode(NewsData.self, from: safeData)
                    for i in 0..<decodedData.articles!.count{
                        let currentItem = decodedData.articles![i]
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
