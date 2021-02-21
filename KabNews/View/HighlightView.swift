//
//  HighlightView.swift
//  KabNews
//
//  Created by Christian Kabouchy on 3/22/20.
//  Copyright © 2020 Christian Kabouchy. All rights reserved.
//

import SwiftUI
import Firebase
import GoogleSignIn

struct HighlightView: View {
    @Environment(\.verticalSizeClass) var sizeClass
    @EnvironmentObject var newsItem : NewsManager
    var newsCategory : [NewsModel]
    @State var newsID : Int
    @State var isPresented = false
    
    var body: some View {
        
        let currentNewsItem = newsCategory[newsID]
        let dateString = currentNewsItem.date
        let date = dateString?.replacingOccurrences(of: "T", with: " ")
        let finalDate = date?.replacingOccurrences(of: "Z", with: " ")
        let imageLoader = ImageLoader(imageString: currentNewsItem.imageUrl)
        
        return GeometryReader{ geo in
            ZStack{
                //Background color
                Color("baseColor")
                    .edgesIgnoringSafeArea(.all)
                //MARK: -Portrait Mode
                if sizeClass == .regular {
                    VStack{
                        //Image
                        Image(uiImage: imageLoader.image)
                            .resizable()
                            .edgesIgnoringSafeArea(.all).frame( height: geo.size.height/3,alignment: .top)
                        ZStack (alignment: .topLeading) {
                            Color("baseColor")
                                .edgesIgnoringSafeArea(.all)
                                .frame( height: geo.size.height/1.5,alignment: .top)
                            VStack(alignment:.center) {
                                VStack (alignment: .leading) {
                                    //News details
                                    Text("\(currentNewsItem.sourceName ?? "No Source")")
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                    Text(currentNewsItem.author ?? "No Author")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                    Text(finalDate ?? "No Date")
                                        .font(.caption)
                                        .fontWeight(.bold)
                                    Divider()
                                    Text("\(currentNewsItem.title ?? "No Title")")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .padding(.bottom)
                                    Text(currentNewsItem.description ?? "No Discription")
                                        .font(.body)
                                        .fontWeight(.bold)
                                        .padding(.bottom)
                                    Spacer()
                                    
                                }.padding()
                                // Read article button
                                Button(action: {self.isPresented.toggle()}){
                                    Text("Read full article")
                                        .bold()
                                        .padding()
                                        .frame(width: geo.size.width - 100,height: 50 ,alignment: .center)
                                        .foregroundColor(Color.white)
                                        .background(Color("secondColor"))
                                        .cornerRadius(10)
                                }.padding(.bottom)
                                //Open a web view when button is pressed
                                .sheet(isPresented: self.$isPresented) {
                                    WebView(url: currentNewsItem.newsUrl)
                                }
                            }
                            
                            
                        }
                        
                    }
                //MARK: -<#Section Name#>
                }else{
                    HStack{
                        //Image
                        Image(uiImage: imageLoader.image)
                            .resizable()
                            .edgesIgnoringSafeArea(.all).frame( width: geo.size.width/3,alignment: .top)
                        ZStack (alignment: .topLeading) {
                            Color("baseColor")
                                .edgesIgnoringSafeArea(.all)
                                .frame( height: geo.size.height/1.5,alignment: .top)
                            VStack(alignment:.center) {
                                VStack (alignment: .leading) {
                                    //News details
                                    Text("\(currentNewsItem.sourceName ?? "No Source")")
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                    Text(currentNewsItem.author ?? "No Author")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                    Text(finalDate ?? "No Date")
                                        .font(.caption)
                                        .fontWeight(.bold)
                                    Divider()
                                    Text("\(currentNewsItem.title ?? "No Title")")
                                        .font(.body)
                                        .fontWeight(.bold)
                                        .padding(.bottom)
                                    Text(currentNewsItem.description ?? "No Discription")
                                        .font(.body)
                                        .fontWeight(.bold)
                                        .padding(.bottom)
                                    Spacer()
                                    
                                }.padding()
                                // Read article button
                                Button(action: {self.isPresented.toggle()}){
                                    Text("Read full article")
                                        .bold()
                                        .padding()
                                        .frame(width: geo.size.height - 100,height: 50 ,alignment: .center)
                                        .foregroundColor(Color.white)
                                        .background(Color("secondColor"))
                                        .cornerRadius(10)
                                }.padding(.bottom)
                                //Open a web view when button is pressed
                                .sheet(isPresented: self.$isPresented) {
                                    WebView(url: currentNewsItem.newsUrl)
                                }
                            }
                            
                            
                        }
                        
                    }
                }
            }
        }
    }
}
//struct HighlightView_Previews: PreviewProvider {
//    static var previews: some View {
//        HighlightView(newsID: 5).environment(\.colorScheme, .dark)
//    }
//}
