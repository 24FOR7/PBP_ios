//
//  NewPoll.swift
//  PublicPoll
//
//  Created by 정우 on 2022/05/29.
//

import SwiftUI

struct NewPoll: View {
    let token:String
    @State var content:String = ""
    @State var isPublic:Bool = true
    @State var showNick:Bool = true
    @State var canRevote:Bool = true
    @State var canComment:Bool = true
    @State var isSingleVote:Bool = true
    
    var body: some View {
        ScrollView{
            VStack{
                Text("New Poll")
                    .font(.system(size: 28))
                    .foregroundColor(Color("lavender"))
                    .padding(.bottom, 30)
                
                //contents
                VStack{
                    Text("Contents")
                        .bold()
                        .font(.system(size: 15))
                        .foregroundColor(Color("signupText"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    TextEditor(text: $content)
                        .frame(height: 80)
                        .cornerRadius(10)
                        .shadow(radius: 1)
                        .padding(.bottom, 20)
                }
                
                //options
                VStack{
                    Text("Options")
                        .bold()
                        .font(.system(size: 15))
                        .foregroundColor(Color("signupText"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .frame(height: 145)
                            .foregroundColor(Color("deepGray"))
                        
                        VStack{
                            HStack{
                                
                            }
                            HStack{
                                
                            }
                        }
                    }.padding(.bottom, 20)
                }
                
                //tags
                VStack{
                    Text("Tags")
                        .bold()
                        .font(.system(size: 15))
                        .foregroundColor(Color("signupText"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    TextEditor(text: $content)
                        .frame(height: 80)
                        .cornerRadius(10)
                        .shadow(radius: 1)
                        .padding(.bottom, 20)
                }
                
                //deadline
                VStack{
                    Text("Deadline")
                        .bold()
                        .font(.system(size: 15))
                        .foregroundColor(Color("signupText"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    PickDeadline().frame(maxWidth: .infinity, alignment: .center)
                }
                
                VStack(spacing: 10){
                    Text("Properties")
                        .bold()
                        .font(.system(size: 15))
                        .foregroundColor(Color("signupText"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    PrivateGroups{ selected in
                        switch selected {
                        case "public":
                            isPublic = true
                        case "Woman":
                            isPublic = false
                        default:
                            break
                        }
                        print(isPublic)
                    }.frame(maxWidth: .infinity, alignment: .leading)
                    
                    NickGroups{ selected in
                        switch selected {
                        case "show nickName":
                            showNick = true
                        case "hide nickName":
                            showNick = false
                        default:
                            break
                        }
                        print(showNick)
                    }.frame(maxWidth: .infinity, alignment: .leading)
                    
                    RevoteGroups{ selected in
                        switch selected {
                        case "revote available":
                            canRevote = true
                        case "revote unavailable":
                            canRevote = false
                        default:
                            break
                        }
                        print(canRevote)
                    }.frame(maxWidth: .infinity, alignment: .leading)
                    
                    CommentGroups{ selected in
                        switch selected {
                        case "comment available":
                            canComment = true
                        case "comment unavailable":
                            canComment = false
                        default:
                            break
                        }
                        print(canComment)
                    }.frame(maxWidth: .infinity, alignment: .leading)
                    
                    MultipleGroups{ selected in
                        switch selected {
                        case "single vote":
                            isSingleVote = true
                        case "multiple vote":
                            isSingleVote = false
                        default:
                            break
                        }
                        print(isSingleVote)
                    }.frame(maxWidth: .infinity, alignment: .leading)
                }.padding(.bottom, 30)
                
                NavigationLink(destination: Home().navigationBarBackButtonHidden(true), label: {
                    Button(action: {}){
                        Text("Done")
                            .frame(width: 250, height: 60, alignment: .center)
                            .background(Color("lavender"))
                            .foregroundColor(.white)
                            .cornerRadius(15)
                    }
                })
                
            }.padding(.leading, 50)
                .padding(.trailing, 50)
        }
    }
}

enum Private: String{
    case pbl = "public"
    case prv = "private"
}
//공개 투표여부 라디오 그룹
struct PrivateGroups: View{
    let callback: (String) -> ()
    
    @State var selectedId: String = ""
    
    var body: some View{
        HStack{
            showPbl
            showPrv
        }
    }
    
    var showPbl: some View{
        RadioButton(
            id: Private.pbl.rawValue,
            label: Private.pbl.rawValue,
            width: 145,
            textSize: 12,
            isMarked: selectedId == Private.pbl.rawValue ? true : false,
            callback: radioGroupCallback)
    }
    
    var showPrv: some View{
        RadioButton(
            id: Private.prv.rawValue,
            label: Private.prv.rawValue,
            width: 145,
            textSize: 12,
            isMarked: selectedId == Private.prv.rawValue ? true : false,
            callback: radioGroupCallback)
    }
    
    func radioGroupCallback(id: String){
        selectedId = id
        callback(id)
    }
}

enum Nick: String{
    case show = "show nickname"
    case hide = "hide nickname"
}
//이름 공개 라디오 그룹
struct NickGroups: View{
    let callback: (String) -> ()
    
    @State var selectedId: String = ""
    
    var body: some View{
        HStack{
            showNick
            hideNick
        }
    }
    
    var showNick: some View{
        RadioButton(
            id: Nick.show.rawValue,
            label: Nick.show.rawValue,
            width: 145,
            textSize: 12,
            isMarked: selectedId == Nick.show.rawValue ? true : false,
            callback: radioGroupCallback)
    }
    
    var hideNick: some View{
        RadioButton(
            id: Nick.hide.rawValue,
            label: Nick.hide.rawValue,
            width: 145,
            textSize: 12,
            isMarked: selectedId == Nick.hide.rawValue ? true : false,
            callback: radioGroupCallback)
    }
    
    func radioGroupCallback(id: String){
        selectedId = id
        callback(id)
    }
}

enum Revote: String{
    case reva = "revote available"
    case revun = "revote unavailable"
}
//재투표 가능여부 라디오 그룹
struct RevoteGroups: View{
    let callback: (String) -> ()
    
    @State var selectedId: String = ""
    
    var body: some View{
        HStack{
            revoteAva
            revoteUnava
        }
    }
    
    var revoteAva: some View{
        RadioButton(
            id: Revote.reva.rawValue,
            label: Revote.reva.rawValue,
            width: 145,
            textSize: 12,
            isMarked: selectedId == Revote.reva.rawValue ? true : false,
            callback: radioGroupCallback)
    }
    
    var revoteUnava: some View{
        RadioButton(
            id: Revote.revun.rawValue,
            label: Revote.revun.rawValue,
            width: 145,
            textSize: 12,
            isMarked: selectedId == Revote.revun.rawValue ? true : false,
            callback: radioGroupCallback)
    }
    
    func radioGroupCallback(id: String){
        selectedId = id
        callback(id)
    }
}

enum Comment: String{
    case coma = "comment available"
    case comun = "comment unavailable"
}
//댓글 가능여부 라디오 그룹
struct CommentGroups: View{
    let callback: (String) -> ()
    
    @State var selectedId: String = ""
    
    var body: some View{
        HStack{
            commAva
            commUnava
        }
    }
    
    var commAva: some View{
        RadioButton(
            id: Comment.coma.rawValue,
            label: Comment.coma.rawValue,
            width: 145,
            textSize: 12,
            isMarked: selectedId == Comment.coma.rawValue ? true : false,
            callback: radioGroupCallback)
    }
    
    var commUnava: some View{
        RadioButton(
            id: Comment.comun.rawValue,
            label: Comment.comun.rawValue,
            width: 145,
            textSize: 12,
            isMarked: selectedId == Comment.comun.rawValue ? true : false,
            callback: radioGroupCallback)
    }
    
    func radioGroupCallback(id: String){
        selectedId = id
        callback(id)
    }
}

enum Multiple: String{
    case single = "single vote"
    case multiple = "multiple vote"
}
//중복투표 라디오 그룹
struct MultipleGroups: View{
    let callback: (String) -> ()
    
    @State var selectedId: String = ""
    
    var body: some View{
        HStack{
            singleVote
            multiVote
        }
    }
    
    var singleVote: some View{
        RadioButton(
            id: Multiple.single.rawValue,
            label: Multiple.single.rawValue,
            width: 145,
            textSize: 12,
            isMarked: selectedId == Multiple.single.rawValue ? true : false,
            callback: radioGroupCallback)
    }
    
    var multiVote: some View{
        RadioButton(
            id: Multiple.multiple.rawValue,
            label: Multiple.multiple.rawValue,
            width: 145,
            textSize: 12,
            isMarked: selectedId == Multiple.multiple.rawValue ? true : false,
            callback: radioGroupCallback)
    }
    
    func radioGroupCallback(id: String){
        selectedId = id
        callback(id)
    }
}

struct NewPoll_Previews: PreviewProvider {
    static var previews: some View {
        NewPoll(token: String())
    }
}
