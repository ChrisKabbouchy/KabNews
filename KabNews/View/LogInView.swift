//
//  LogInView.swift
//  KabNews
//
//  Created by Christian Kabouchy on 4/3/20.
//  Copyright © 2020 Christian Kabouchy. All rights reserved.
//

import SwiftUI
import Firebase
import GoogleSignIn

struct LogInView: View {
    
    @State var email :  String = ""
    @State var password : String = ""
    @State var isPresented : Bool = false
    @State var showingAlert = false
    
    var body: some View {
        GeometryReader{ geo in
            ZStack(alignment: .center){
                
                Color("baseColor")
                    .edgesIgnoringSafeArea(.all)
                VStack(alignment: .center, spacing: 20){
                    Text("Login")
                        .font(.title)
                        .bold()
                        .padding()
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
                        Auth.auth().signIn(withEmail: self.email, password: self.password) { authResult, error in
                            if error != nil{
                                print(error!)
                                return
                            }
                            print(authResult?.user.displayName ?? " " )
                            UserDefaults.standard.set(authResult?.user.displayName, forKey: "user-name")
                            UserDefaults.standard.set(true, forKey: "logged-in")
                            NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
                            self.showingAlert.toggle()
                        }
                        
                    }
                    ){
                        Text("LOGIN")
                            .bold()
                            .padding(.horizontal)
                            .frame(width: geo.size.width - 100,height: 50 ,alignment: .center)
                            .foregroundColor(Color.white)
                            .background(Color("secondColor"))
                            .cornerRadius(10)
                    }.alert(isPresented: self.$showingAlert){
                        Alert(title: Text("hello"), message: Text("hello"),dismissButton: .default(Text("ok")))
                    }
                    GoogleSignView()
                        .frame(width: 150, height: 50)
                    
                    VStack{
                        Text("Don't have an account yet?")
                            .font(.headline)
                            .bold()
                            .padding(.bottom)
                        Button(action:{self.isPresented.toggle() } ){
                            Text("SignUp")
                                .bold()
                                .foregroundColor(Color.white)
                                .padding()
                                .background(Color("secondColor"))
                                .cornerRadius(10)
                        }.sheet(isPresented: self.$isPresented) {
                            SignUpView()
                        }
                    }
                    
                }
            }
        }
    }
}
struct GoogleSignView : UIViewRepresentable {
    
    func makeUIView(context: UIViewRepresentableContext<GoogleSignView>) -> GIDSignInButton {
        
        let button = GIDSignInButton()
        button.colorScheme = .light
        GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.last?.rootViewController
        return button
        
    }
    
    func updateUIView(_ uiView: GIDSignInButton, context: UIViewRepresentableContext<GoogleSignView>) {
        
        
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
