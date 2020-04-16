//
//  SignUpView.swift
//  KabNews
//
//  Created by Christian Kabouchy on 4/5/20.
//  Copyright © 2020 Christian Kabouchy. All rights reserved.
//

import SwiftUI
import Firebase
import GoogleSignIn

struct SignUpView: View {
    @State var email :  String = ""
    @State var password : String = ""
    @State var name : String = ""
    
    var body: some View {
        
        GeometryReader{ geo in
            
            ZStack(alignment: .center){
                
                Color("baseColor")
                    .edgesIgnoringSafeArea(.all)
                VStack(alignment: .center, spacing: 20){
                    Text("SignUp")
                        .font(.title)
                        .bold()
                        .padding()
                    
                    HStack(alignment: .center){
                        Image(systemName: "person.fill")
                            .padding(.horizontal)
                        TextField("Enter your email", text: self.$name)
                    }.frame(width:geo.size.width - 100,height: 50 )
                        .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("secondColor"), lineWidth: 4))
                    
                    HStack(){
                        Image(systemName: "envelope.fill")
                            .padding(.horizontal)
                        TextField("Enter your email", text: self.$email)
                    }.frame(width:geo.size.width - 100,height: 50 )
                        .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("secondColor"), lineWidth: 4))
                    
                    HStack{
                        Image(systemName: "lock.fill")
                            .padding(.horizontal)
                        SecureField("Enter your password", text: self.$password)
                    }.frame(width:geo.size.width - 100,height: 50 )
                        .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("secondColor"), lineWidth: 4))
                    
                    Button(action:{
                        Auth.auth().createUser(withEmail: self.email, password: self.password) { authResult, error in
                            if error != nil{
                                print(error!)
                                return
                            }
                            print(authResult?.user.email ?? "no name" )
                            UserDefaults.standard.set(self.name, forKey: "user-name")
                            UserDefaults.standard.set(true, forKey: "logged-in")
                            NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
                        }
                        
                    } ){
                        Text("SIGNUP")
                            .bold()
                            .padding(.horizontal)
                            .frame(width: geo.size.width - 100,height: 50 ,alignment: .center)
                            .foregroundColor(Color.white)
                            .background(Color("secondColor"))
                            .cornerRadius(10)
                    }
                }
            }
            
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
