//
//  SignUpDetail.swift
//  PublicPoll
//
//  Created by 정우 on 2022/05/18.
//

import SwiftUI
import Firebase
import Foundation
import Alamofire

struct SignUpDetail: View {
    @State var nick:String = ""
    @State var age:Int = 0
    @State var gender:String = "m"
    @State var token:String = "no token"
    var email:String
    @State var success:Bool = false
    
    @State var req = SignUpHTTP()
    
    var body: some View {
        VStack{
            Text("Sign Up")
                .font(.title)
                .fontWeight(.regular)
                .foregroundColor(Color("lavender"))
                .padding(.bottom, 60.0)
            
            HStack{
                Text("NickName")
                    .bold()
                    .foregroundColor(Color("signupText"))
                    .padding(.leading, 55.0)
                    .font(.system(size: 16))
                
                Text("2~15 letters")
                    .foregroundColor(Color(red: 0.757, green: 0.757, blue: 0.757))
                    .font(.system(size: 10))
            }.frame(maxWidth: .infinity, alignment: .leading)
            
            TextField("", text: $nick)
                .frame(width: 280)
                .textFieldStyle(.roundedBorder)
                .padding(.bottom, 30)
            
            //성별
            Text("Gender")
                .bold()
                .foregroundColor(Color("signupText"))
                .font(.system(size: 16))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 55.0)
            
            GenderGroups{ selected in
                switch selected {
                case "Man":
                    gender = "m"
                case "Woman":
                    gender = "f"
                default:
                    break
                }
                print(gender)
            }.frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 55)
                .padding(.bottom, 30)
            
            //나이
            Text("Age")
                .bold()
                .foregroundColor(Color("signupText"))
                .font(.system(size: 16))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 55.0)
            
            AgeGroups{ selected in
                switch selected {
                case "~10s":
                    age = 10
                case "20s":
                    age = 20
                case "30s":
                    age = 30
                case "40s":
                    age = 40
                case "50s~":
                    age = 50
                default:
                    break
                }
                print(age)
            }.frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 55)
                .padding(.bottom, 30)
            
            //해시태그
            HStack{
                Text("Interest Tags")
                    .bold()
                    .foregroundColor(Color("signupText"))
                    .padding(.leading, 55.0)
                    .font(.system(size: 16))
                
                Text("choose 3 tags")
                    .bold()
                    .foregroundColor(Color(red: 0.757, green: 0.757, blue: 0.757))
                    .font(.system(size: 10))
            }.frame(maxWidth: .infinity, alignment: .leading)
            
            HashGroups(){ selected in
                
            }.padding(.bottom, 30)
            
            NavigationLink(destination: ContentView().navigationBarBackButtonHidden(true),
                           isActive: $success, label: {
                Button(action: {
                    getToken()
                }){
                    Text("Join")
                        .bold()
                        .frame(width: 250, height: 60, alignment: .center)
                        .background(Color("skyBlue"))
                        .foregroundColor(.white)
                        .cornerRadius(15)
                }.padding(.bottom, 80)
            })
        }
    }
    
    func getToken(){
        let currentUser = Auth.auth().currentUser
        print(currentUser?.uid)
        currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
          if let error = error {
            print("error")
            return;
          }
            token = idToken!
            success = self.req.postAuth(token: token,email: email, nick: nick, age: age, gender: gender, interest1: "tv", interest2: "basketball", interest3: "developing")
            success = true
        }
    }
}

enum Gender: String{
    case man = "Man"
    case woman = "Woman"
}

enum Age: String{
    case teen =  "~10s"
    case twenty = "20s"
    case thirty = "30s"
    case firty =  "40s"
    case fifty = "50s~"
}



//성별 라디오 그룹
struct GenderGroups: View{
    let callback: (String) -> ()
    
    @State var selectedId: String = ""
    
    var body: some View{
        HStack{
            radioMan
            radioWoman
        }
    }
    
    var radioMan: some View{
        RadioButton(
            id: Gender.man.rawValue,
            label: Gender.man.rawValue,
            width: 80,
            textSize: 14,
            isMarked: selectedId == Gender.man.rawValue ? true : false,
            callback: radioGroupCallback)
    }
    
    var radioWoman: some View{
        RadioButton(
            id: Gender.woman.rawValue,
            label: Gender.woman.rawValue,
            width: 80,
            textSize: 14,
            isMarked: selectedId == Gender.woman.rawValue ? true : false,
            callback: radioGroupCallback)
    }
    
    func radioGroupCallback(id: String){
        selectedId = id
        callback(id)
    }
}

//나이 라디오 그룹
struct AgeGroups: View{
    let callback: (String) -> ()
    
    @State var selectedId: String = ""
    
    var body: some View{
        VStack{
            HStack{
                radioTeen
                radioTwenty
                radioThirty
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            HStack{
                radioFirty
                radioFifty
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    var radioTeen: some View{
        RadioButton(
            id: Age.teen.rawValue,
            label: Age.teen.rawValue,
            width: 80,
            textSize: 14,
            isMarked: selectedId == Age.teen.rawValue ? true : false,
            callback: radioGroupCallback)
    }
    
    var radioTwenty: some View{
        RadioButton(
            id: Age.twenty.rawValue,
            label: Age.twenty.rawValue,
            width: 80,
            textSize: 14,
            isMarked: selectedId == Age.twenty.rawValue ? true : false,
            callback: radioGroupCallback)
    }
    
    var radioThirty: some View{
        RadioButton(
            id: Age.thirty.rawValue,
            label: Age.thirty.rawValue,
            width: 80,
            textSize: 14,
            isMarked: selectedId == Age.thirty.rawValue ? true : false,
            callback: radioGroupCallback)
    }
    
    var radioFirty: some View{
        RadioButton(
            id: Age.firty.rawValue,
            label: Age.firty.rawValue,
            width: 80,
            textSize: 14,
            isMarked: selectedId == Age.firty.rawValue ? true : false,
            callback: radioGroupCallback)
    }
    
    var radioFifty: some View{
        RadioButton(
            id: Age.fifty.rawValue,
            label: Age.fifty.rawValue,
            width: 80,
            textSize: 14,
            isMarked: selectedId == Age.fifty.rawValue ? true : false,
            callback: radioGroupCallback)
    }
    
    func radioGroupCallback(id: String){
        selectedId = id
        callback(id)
    }
}
let checkList = [
    CheckListItem(title: "#bread"),
    CheckListItem(title: "#sports"),
    CheckListItem(title: "#TV"),
    CheckListItem(title: "#basketball"),
    CheckListItem(title: "#developing"),
]

struct CheckListItem{
    var isChecked: Bool = false
    var title: String
}






//해시태그 커스텀 디자인
struct Hash: View{
    let id: String
    let color: Color
    @State var isSelected: Bool
    //let callback: (String) -> ()
    
    init(
        id: String,
        color: Color = Color("lavender"),
        isSelected: Bool = false
        //callback: @escaping (String) -> ()
    ){
        self.id = id
        self.color = color
        self.isSelected = isSelected
        //self.callback = callback
    }
    
    var body: some View{
        Button(action: {
            isSelected = !isSelected
            for item in checkList{
                if self.id == item.title{
                    //item.isChecked = isSelected
                }
            }
        }){
            Text(id)
                .bold()
                .font(Font.system(size: 12))
                .padding(.leading, 20)
                .padding(.trailing, 20)
                .frame(height: 30, alignment: .center)
                .background(isSelected == true ? color : .white)
                .foregroundColor(isSelected == true ? .white : color)
                .cornerRadius(15)
                .overlay(RoundedRectangle(cornerRadius: 15)
                    .stroke(color))
        }
    }
}

enum HashTag: String{
    case bread = "#bread"
    case sports = "#sports"
    case tv = "#TV"
    case basketball = "#basketball"
    case developing = "#developing"
}

//해시태그 그룹
struct HashGroups: View{
    let callback: (String) -> ()
    
    @State var selectedId: String = ""
    
    var body: some View{
        HStack{
            breadHash
        }
    }
    
    var breadHash: some View{
        VStack{
            HStack{
                Hash(
                    id: checkList[0].title)
                Hash(
                    id: checkList[1].title)
                Hash(
                    id: checkList[2].title)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 55)
            HStack{
                Hash(
                    id: checkList[3].title)
                Hash(
                    id: checkList[4].title)
            }.frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 55)
        }
    }
    
    func hashGroupCallback(id: String){
        selectedId = id
        callback(id)
    }
}

struct SignUpDetail_Previews: PreviewProvider {
    static var previews: some View {
        SignUpDetail(email: String())
    }
}
