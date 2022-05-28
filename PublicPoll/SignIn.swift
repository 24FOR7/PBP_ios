//
//  SignIn.swift
//  PublicPoll
//
//  Created by 정우 on 2022/05/17.
//

import SwiftUI
import Firebase

struct SignIn: View {
    @State var email:String = ""
    @State var password:String = ""
    @State var toHome:Bool = false
    
    var body: some View {
            VStack(){
                Text("Sign In")
                    .font(.title)
                    .fontWeight(.regular)
                    .foregroundColor(Color("lavender"))
                    .padding(.bottom, 60.0)
                Text("E-mail")
                    .foregroundColor(Color(red: 0.694, green: 0.694, blue: 0.694))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 55.0)
                    
                TextField("", text: $email)
                    .frame(width: 280.0)
                    .textFieldStyle(.roundedBorder)
                Spacer().frame(height:30)
                
                Text("Password")
                    .foregroundColor(Color(red: 0.694, green: 0.694, blue: 0.694))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 55.0)
                
                SecureField("", text: $password)
                    .frame(width: 280.0)
                    .textFieldStyle(.roundedBorder)
                Spacer().frame(height:270)
                
                NavigationLink(destination: SignUp(), label: {
                    Text("sign up for free")
                        .font(.system(size: 14))
                })
                
                NavigationLink(destination: Home().navigationBarBackButtonHidden(true), isActive: $toHome){
                    Button(action: trySignIn){
                        Text("Sign In")
                            .bold()
                            .frame(width: 200, height: 50)
                            .background(email.isEmpty || password.isEmpty ? Color("nextGray") : Color("skyBlue"))
                            .foregroundColor(.white)
                            .cornerRadius(15)
                    }
                }
                .padding(.bottom, 80)
            }
        }
    
    func trySignIn(){
        Auth.auth().signIn(withEmail: email, password: password){ (result, error) in
            if error != nil{
                print(error?.localizedDescription ?? "")
            }else{
                print("success")
                toHome = true
            }
        }
    }
}

struct SignIn_Previews: PreviewProvider {
    static var previews: some View {
        SignIn()
    }
}
