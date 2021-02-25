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
    
    @Environment(\.verticalSizeClass) var sizeClass
    @State var email :  String = ""
    @State var password : String = ""
    @State var isPresented : Bool = false
    @State var isPreferencesPresented : Bool = UserDefaults.standard.bool(forKey: "googleLogged-in")
    @State var isSignUpPresented : Bool = false
    @State var alert : Alert?
    @State var showingAlert = false
    
    var body: some View {
        ZStack(alignment: .center){
            //background color
            Color("baseColor")
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .center, spacing: 20){
                //MARK: -Portrait Mode
                if sizeClass == .regular {
                    Text("Login")
                        .font(.title)
                        .bold()
                        .padding()
                    //email text field
                    HStack(){
                        Image(systemName: "envelope.fill")
                            .padding(.horizontal)
                        TextField("Enter your email", text: self.$email)
                    }.frame(width:UIScreen.main.bounds.width - 100,height: 50 )
                    .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("secondColor"), lineWidth: 4))
                    //password text field
                    HStack{
                        Image(systemName: "lock.fill")
                            .padding(.horizontal)
                        SecureField("Enter your password", text: self.$password)
                    }.frame(width:UIScreen.main.bounds.width - 100,height: 50 )
                    .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("secondColor"), lineWidth: 4))
                }
                else{
                    //MARK: -Landscape Mode
                    Text("Login")
                        .font(.title)
                        .bold()
                        .padding()
                    //email text field
                    HStack{
                        HStack(){
                            Image(systemName: "envelope.fill")
                                .padding(.horizontal)
                            TextField("Enter your email", text: self.$email)
                        }.frame(width:UIScreen.main.bounds.height - 100,height: 40 )
                        .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("secondColor"), lineWidth: 4))
                        //password text field
                        HStack{
                            Image(systemName: "lock.fill")
                                .padding(.horizontal)
                            SecureField("Enter your password", text: self.$password)
                        }.frame(width:UIScreen.main.bounds.height - 100,height: 40 )
                        .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("secondColor"), lineWidth: 4))
                    }}
                //Login button
                Button(action:{
                    Auth.auth().signIn(withEmail: self.email, password: self.password) { authResult, error in
                        if error != nil{
                            print(error!)
                            self.alert = Alert(title: Text("Sign-in failed"), message: Text("error: \(error!.localizedDescription)"), dismissButton: .cancel())
                            self.showingAlert.toggle()
                            return
                        }
                        print(authResult?.user.displayName ?? " " )
                        UserDefaults.standard.set(authResult?.user.displayName, forKey: "user-name")
                        isPreferencesPresented.toggle()
                    }
                    
                }
                ){
                    if sizeClass == .regular {
                        //Portarit
                        Text("LOGIN")
                            .bold()
                            .padding(.horizontal)
                            .frame(width:UIScreen.main.bounds.width - 100,height: 50 ,alignment: .center)
                            .foregroundColor(Color.white)
                            .background(Color("secondColor"))
                            .cornerRadius(10)
                    }
                    else{
                        //Landscape
                        Text("LOGIN")
                            .bold()
                            .padding(.horizontal)
                            .frame(width:UIScreen.main.bounds.height - 100,height: 40 ,alignment: .center)
                            .foregroundColor(Color.white)
                            .background(Color("secondColor"))
                            .cornerRadius(10)
                    }
                    
                }.sheet(isPresented: $isPreferencesPresented){
                    PreferencesView()
                }
                .alert(isPresented: self.$showingAlert){
                    self.alert!
                }
                //google sign in button
                GoogleSignView()
                    .frame(width: 150, height: 40)
                
                VStack{
                    Text("Don't have an account yet?")
                        .font(.headline)
                        .bold()
                        .padding(.bottom)
                    //Sign up button
                    Button(action:{self.isSignUpPresented.toggle() } ){
                        Text("SignUp")
                            .bold()
                            .foregroundColor(Color.white)
                            .frame(height:20)
                            .padding()
                            .background(Color("secondColor"))
                            .cornerRadius(10)
                    }.sheet(isPresented: $isSignUpPresented){
                        SignUpView()
                    }
                }
            }.onAppear(){
                //Notify to update the UI when google sign in
                NotificationCenter.default.addObserver(forName: NSNotification.Name("statusChange"), object: nil, queue: .main) { (_) in
                    DispatchQueue.main.async {
                        self.isPreferencesPresented = UserDefaults.standard.bool(forKey: "googleLogged-in")
                    }
                    
                }
                //Notify to update the UI when email sign in or sign up
                NotificationCenter.default.addObserver(forName: NSNotification.Name("PreferencesChange"), object: nil, queue: .main) { (_) in
                    UserDefaults.standard.set(true, forKey: "logged-in")
                    Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false){_ in
                        NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
                    }
                    
                    
                }
            }
            
        }
    }
}
//MARK: -Google SingView
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
