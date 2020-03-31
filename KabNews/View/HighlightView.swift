//
//  HighlightView.swift
//  KabNews
//
//  Created by Christian Kabouchy on 3/22/20.
//  Copyright © 2020 Christian Kabouchy. All rights reserved.
//

import SwiftUI

struct HighlightView: View {
    @ObservedObject var newsManager : NewsManager
    var body: some View {
        NavigationView{
            NavigationLink(destination: MainView()){
                Text(newsManager.news[0].content!)
                
            }
        }
    }
}

//struct HighlightView_Previews: PreviewProvider {
//    static var previews: some View {
//        HighlightView(newsManager: NewsManager.self)
//    }
//}
