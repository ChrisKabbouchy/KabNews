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
    @ObservedObject var newsManager : NewsManager
    @State var email :  String
    @State var password : String
    var body: some View {
        NavigationView{
            VStack{
                TextField("email", text: $email)
                TextField("password", text: $password)
                Button(action:{
                    Auth.auth().signIn(withEmail: self.email, password: self.password) { authResult, error in
                        if error != nil{
                            print(error!)
                            return
                        }
                        print(authResult?.user.email ?? " " )
                    }
                    
                } ){
                    Text("signIn")
                }
                Button(action:{
                    Auth.auth().createUser(withEmail: self.email, password: self.password) { authResult, error in
                        if error != nil{
                            print(error!)
                            return
                    }
                        print(authResult?.user.email ?? " " )
                    }
                    
                } ){
                    Text("signUp")
                }
                GoogleSignView()
                    .frame(width: 150,height: 55)
            }
            
            
            
        }
    }
}
//struct HighlightView_Previews: PreviewProvider {
//    static var previews: some View {
//        HighlightView(newsManager: NewsManager.self)
//    }
//}
