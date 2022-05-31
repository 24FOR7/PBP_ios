//
//  NewPoll.swift
//  PublicPoll
//
//  Created by 정우 on 2022/05/29.
//

import SwiftUI
import WSTagsField

struct NewPoll: View {
    @StateObject var load = LoadQuickPoll()
    let token:String
    @State var content:String = ""
    @State var isPublic:Bool = true
    @State var showNick:Bool = true
    @State var canRevote:Bool = true
    @State var canComment:Bool = true
    @State var isSingleVote:Bool = true
    @State var one:String = ""
    @State var two:String = ""
    @State var text:String = ""
    @State var tags:[[Tag]] = [[]]
    
    //2007-12-03T10:15:30
    let dateformat: DateFormatter = {
        let formatter  = DateFormatter()
        formatter.dateFormat = "YYYY-M-d"
        return formatter
    }()
    let hourformat: DateFormatter = {
        let formatter  = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter
    }()
    @State var selectedDate: Date = Date()
    let endingDate: Date = Calendar.current.date(from: DateComponents(year:2023)) ?? Date()
    let startingDate: Date = Date()
    @State var date2String = ""
    
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
                            .frame(height: 100)
                            .foregroundColor(Color("efefef"))
                        
                        VStack{
                            HStack{
                                Text("1")
                                    .bold()
                                    .font(.system(size: 12))
                                    .foregroundColor(Color("signupText"))
                                    .padding(.trailing, 5)
                                
                                TextField("", text: $one)
                                    .frame(width: 250.0)
                                    .textFieldStyle(.roundedBorder)
                            }
                            HStack{
                                Text("2")
                                    .bold()
                                    .font(.system(size: 12))
                                    .foregroundColor(Color("signupText"))
                                    .padding(.trailing, 5)
                                
                                TextField("", text: $two)
                                    .frame(width: 250.0)
                                    .textFieldStyle(.roundedBorder)
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
                    
                    HStack{
                        TextEditor(text: $text)
                            .frame(width: 260, height: 30)
                            .cornerRadius(10)
                            .shadow(radius: 1)
                        Button(action: {
                            withAnimation(.default){
                                tags[tags.count - 1].append(Tag(tagText: text))
                                text = ""
                            }
                        }) {
                            Image(systemName: "plus.app")
                                .font(.largeTitle)
                                .frame(width: 30, height: 30, alignment: .center)
                                .foregroundColor(Color("lavender"))
                        }.disabled(text == "")
                            .opacity(text == "" ? 0.45 : 1)
                    }
                    
                    VStack{
                        ForEach(tags.indices, id:\.self){index in
                            HStack{
                                ForEach(tags[index].indices, id:\.self){tagIndex in
                                    Text(tags[index][tagIndex].tagText)
                                        .font(.system(size: 12))
                                        .padding(.vertical, 6)
                                        .padding(.horizontal)
                                        //.foregroundColor(.white)
                                        .background(Color("lavender"))
                                        .foregroundColor(.white)
                                        .cornerRadius(15)
                                        .overlay(RoundedRectangle(cornerRadius: 15)
                                            .stroke(Color("lavender")))
                                        .lineLimit(1)
                                        .overlay(
                                            GeometryReader{reader -> Color in
                                                let maxX = reader.frame(in: .global).maxX
                                                if maxX > UIScreen.main.bounds.width - 60 && !tags[index][tagIndex].isExceeded{
                                                    DispatchQueue.main.async {
                                                        tags[index][tagIndex].isExceeded = true
                                                        let lastItem = tags[index][tagIndex]
                                                        
                                                        tags.append([lastItem])
                                                        tags[index].remove(at: tagIndex)
                                                    }
                                                }
                                                
                                                return Color.clear
                                            }).clipShape(RoundedRectangle(cornerRadius: 15))
                                        .onTapGesture{
                                            tags[index].remove(at: tagIndex)
                                            
                                            if tags[index].isEmpty{
                                                tags.remove(at: index)
                                            }
                                        }
                                }
                            }
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width - 100, height: 60, alignment: .topLeading)
                }.padding(.bottom, 20)
                
                //deadline
                VStack{
                    Text("Deadline")
                        .bold()
                        .font(.system(size: 15))
                        .foregroundColor(Color("signupText"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    DatePicker("", selection: $selectedDate, in: startingDate...endingDate, displayedComponents: [.date, .hourAndMinute])
                        .accentColor(Color("lavender"))
                        .datePickerStyle(CompactDatePickerStyle())
                        .labelsHidden()
                        .environment(\.locale, Locale.init(identifier: "en"))
                        .transformEffect(.init(scaleX: 0.8, y: 0.8))
                        .padding(.leading, 40)
                }.padding(.bottom, 20)
                
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
                        case "private":
                            isPublic = false
                        default:
                            break
                        }
                        print(isPublic)
                    }.frame(maxWidth: .infinity, alignment: .leading)
                    
                    NickGroups{ selected in
                        switch selected {
                        case "show nickname":
                            showNick = true
                        case "hide nickname":
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
                    Button(action: {
                        //deadline Date to String
                        date2String = dateformat.string(from: selectedDate) + "T" + hourformat.string(from: selectedDate) + "."
                        
                        print(token)
                        print(content)
                        print(one)
                        print(two)
                        print(isPublic)
                        print(showNick)
                        print(canRevote)
                        print(canComment)
                        print(isSingleVote)
                        print(date2String)
                        
                        load.makeBallot(token: token, hashTags: ["test"], contents: content, endTime: date2String, isPublic: isPublic, showNick: showNick, canRevote: canRevote, canComment: canComment, isSingleVote: isSingleVote, one: one, two: two)
                    }){
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

struct Tag: Identifiable{
    var id = UUID().uuidString
    var tagText: String
    var isExceeded = false
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
