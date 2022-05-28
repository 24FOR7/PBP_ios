//
//  SignUp.swift
//  PublicPoll
//
//  Created by 정우 on 2022/05/17.
//

import SwiftUI
import Firebase

struct SignUp: View {
    @State var email:String = ""
    @State var password:String = ""
    @State var chkpass:String = ""
    @State var toNext:Bool = false
    var body: some View {
        VStack{
            Text("Sign Up")
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
            Spacer().frame(height:30)
            
            Text("Check Password")
                .foregroundColor(Color(red: 0.694, green: 0.694, blue: 0.694))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 55.0)
            
            SecureField("", text: $chkpass)
                .frame(width: 280.0)
                .textFieldStyle(.roundedBorder)
                .padding(.bottom, 220.0)
            
            NavigationLink(destination: SignUpDetail(email: email).navigationBarBackButtonHidden(true),isActive: $toNext, label: {
                Button(action: createAccount){
                    Text("Next")
                        .frame(width: 250, height: 60, alignment: .center)
                        .background(Color("nextGray"))
                        .foregroundColor(.white)
                        .cornerRadius(15)
                }
            })
            .disabled(email.isEmpty || password.isEmpty || chkpass.isEmpty || password != chkpass)
            .padding(.bottom, 80)
        }
    }
    private func createAccount(){
        Auth.auth().createUser(withEmail: email, password: password){
            result, err in
            if let err = err{
                print("Failed to create user:", err)
                return
            }
            print("Successfully create user: \(result?.user.uid ?? "")")
            toNext = true
        }
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}
