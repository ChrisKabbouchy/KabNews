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
        case 15 :
            return "hk"
        case 16 :
            return "hu"
        case 17 :
            return "in"
        case 18 :
            return "id"
        case 19 :
            return "ie"
        case 20 :
            return "it"
        case 21 :
            return "jp"
        case 22 :
            return "lv"
        case 23 :
            return "lt"
        case 24 :
            return "my"
        case 25 :
            return "mx"
        case 26 :
            return "ma"
        case 27 :
            return "nl"
        case 28 :
            return "nz"
        case 29 :
            return "ng"
        case 30 :
            return "no"
        case 31 :
            return "ph"
        case 32 :
            return "pl"
        case 33 :
            return "pt"
        case 34 :
            return "ro"
        case 35 :
            return "ru"
        case 36 :
            return "sa"
        case 37 :
            return "rs"
        case 38 :
            return "sg"
        case 39 :
            return "sk"
        case 40 :
            return "si"
        case 41 :
            return "za"
        case 42 :
            return "kr"
        case 43 :
            return "se"
        case 44 :
            return "ch"
        case 45 :
            return "tw"
        case 46 :
            return "th"
        case 47 :
            return "tr"
        case 48 :
            return "ae"
        case 49 :
            return "ua"
        case 50 :
            return "gb"
        case 51 :
            return "us"
        case 52 :
            return "ve"
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
        let categoryString = category.replacingOccurrences(of: " ", with: "%20")
        var finalUrl = ""
        if !isSearchResult {
            finalUrl = "\(baseUrl)\(country)&category=\(categoryString)&apiKey=\(apiKey)"
            print(finalUrl)
        }
        else{
            finalUrl = "\(searchUrl)\(categoryString)&apiKey=\(apiKey)"
        }
        if let url = URL(string: finalUrl){
        
        var request = URLRequest(url: url)
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
        
        }else{
            print(finalUrl)
        }
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
