//
//  ImageLoader.swift
//  KabNews
//
//  Created by Christian Kabouchy on 3/31/20.
//  Copyright © 2020 Christian Kabouchy. All rights reserved.
//

import Foundation
import SwiftUI


class ImageLoader: ObservableObject {
    @Published var dataIsValid = false
    var data:Data?
    @Published var image = UIImage(systemName: "photo.fill")!
    var imageCache = ImageCache.getImageCache()
    var imageString : String?
    
    init(imageString:String?) {
        self.imageString = imageString
        load()
    }
    func load() {
        if loadImageFromCache(urlString: imageString) {
            return
        }
        loadImage(urlString: imageString)
    }
    
    func loadImage (urlString:String?) {
        if let safeUrl = urlString {
            guard let url = URL(string: safeUrl) else { return }
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data else { return }
                DispatchQueue.main.async {
                    self.dataIsValid = true
                    self.data = data
                    self.image = UIImage(data: data) ?? UIImage(systemName: "photo.fill")!
                    self.imageCache.set(forKey: urlString!, image: self.image)
                    print("load")
                }
            }
            task.resume()
        }
    }
    
    func loadImageFromCache(urlString:String?) -> Bool {
        guard let urlString = urlString else {
            return false
        }
        
        guard let cacheImage = imageCache.get(forKey: urlString) else {
            return false
        }
        
        image = cacheImage
        return true
    }
}

class ImageCache {
    var cache = NSCache<NSString, UIImage>()
    
    func get(forKey: String) -> UIImage? {
        return cache.object(forKey: NSString(string: forKey))
    }
    
    func set(forKey: String, image: UIImage) {
        cache.setObject(image, forKey: NSString(string: forKey))
    }
}

extension ImageCache {
    private static var imageCache = ImageCache()
    static func getImageCache() -> ImageCache {
        return imageCache
    }
}
