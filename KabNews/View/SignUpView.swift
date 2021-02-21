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
    @Environment(\.verticalSizeClass) var sizeClass
    @State var email :  String = ""
    @State var password : String = ""
    @State var name : String = ""
    @State var alert : Alert?
    @State var showingAlert = false
    @State var isPresented : Bool = false
    
    var body: some View {
        ZStack(alignment: .center){
            //background color
            Color("baseColor")
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .center , spacing: 20){
                Text("SignUp")
                    .font(.title)
                    .bold()
                    .padding()
                //Name text field
                HStack(alignment: .center){
                    Image(systemName: "person.fill")
                        .padding(.horizontal)
                    TextField("Enter your name", text: self.$name)
                }.frame(width:UIScreen.main.bounds.width - 100,height: 50 )
                .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("secondColor"), lineWidth: 4))
                //Email text field
                HStack(){
                    Image(systemName: "envelope.fill")
                        .padding(.horizontal)
                    TextField("Enter your email", text: self.$email)
                }.frame(width:UIScreen.main.bounds.width - 100,height: 50 )
                .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("secondColor"), lineWidth: 4))
                //Password field
                HStack{
                    Image(systemName: "lock.fill")
                        .padding(.horizontal)
                    SecureField("Enter your password", text: self.$password)
                }.frame(width:UIScreen.main.bounds.width - 100,height: 50 )
                .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("secondColor"), lineWidth: 4))
                //SIGNUP BUTTON
                Button(action:{
                    Auth.auth().createUser(withEmail: self.email, password: self.password) { authResult, error in
                        if error != nil{
                            print(error!)
                            self.alert = Alert(title: Text("Sign-in failed"), message: Text("error: \(error!.localizedDescription)"), dismissButton: .cancel())
                            self.showingAlert.toggle()
                            return
                        }
                        print(authResult?.user.email ?? "no name" )
                        UserDefaults.standard.set(self.name, forKey: "user-name")
                        self.isPresented.toggle()
                        NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
                    }
                    
                } ){
                    Text("SIGNUP")
                        .bold()
                        .padding(.horizontal)
                        .frame(width: UIScreen.main.bounds.width - 100,height: 50 ,alignment: .center)
                        .foregroundColor(Color.white)
                        .background(Color("secondColor"))
                        .cornerRadius(10)
                }.sheet(isPresented: $isPresented){
                    PreferencesView()
                }
                .alert(isPresented: self.$showingAlert){
                    self.alert!
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
