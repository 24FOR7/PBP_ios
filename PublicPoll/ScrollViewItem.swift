//
//  ScrollViewItem.swift
//  PublicPoll
//
//  Created by 정우 on 2022/06/03.
//

import SwiftUI

struct ScrollViewItem: View {
    @StateObject var load = LoadQuickPoll()
    let token:String
    @State var content:String
    @State var id:Int
    @State var btn1Content:String
    @State var btn2Content:String
    @State var btn1Rate:Float = 0.0
    @State var btn2Rate:Float = 0.0
    @State var isBtnClicked:Int = 0
    @State var onceClicked:Bool = false
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .frame(width: 300, height: 330)
            VStack{
                Text(content)
                    .font(.system(size: 25))
                    .frame(width: 230, alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.bottom, 30)
                Button(action: {
                    isBtnClicked = 1
                    let itemNum:[Int] = [1]
                    if !onceClicked {
                        do{
                            load.quickVote(token: token, pollId: id, itemNum: itemNum)
                            DispatchQueue.main.async {
                                btn1Rate = load.voteReturn.data[0].percent
                                btn2Rate = load.voteReturn.data[1].percent
                            }
                        }catch(let err){
                            print(err)
                        }
                    }
                    else{
                        do{
                            
                            DispatchQueue.main.async {
                                load.quickRevote(token: token, pollId: id, itemNum: itemNum)
                                btn1Rate = load.voteReturn.data[0].percent
                                btn2Rate = load.voteReturn.data[1].percent
                            }
                        }catch(let err){
                            print(err)
                        }
                    }
                    onceClicked = true
                }) {
                    HStack{
                        Text(btn1Content)
                        Spacer()
                        Text(isBtnClicked != 0 ? String(format: "%.1f", btn1Rate) + "%" : "")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
                    .foregroundColor(btn1Rate>btn2Rate ? .black : Color("signupText"))
                    .font(.system(size: 15))
                    .frame(width: 230, height: 40, alignment: .center)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(red: 0.704, green: 0.714, blue: 0.909), lineWidth: 4))
                    .background(isBtnClicked == 1 ? Color(red: 0.912, green: 0.922, blue: 0.999) : Color(.white))
                }.cornerRadius(10)
                    .padding(.bottom, 10)
                    
                Button(action: {
                    isBtnClicked = 2
                    let itemNum:[Int] = [2]
                    if !onceClicked {
                        do{
                            load.quickVote(token: token, pollId: id, itemNum: itemNum)
                            DispatchQueue.main.async {
                                btn1Rate = load.voteReturn.data[0].percent
                                btn2Rate = load.voteReturn.data[1].percent
                            }
                        }catch(let err){
                            print(err)
                        }
                    }
                    else{
                        do{
                            load.quickRevote(token: token, pollId: id, itemNum: itemNum)
                            DispatchQueue.main.async {
                                btn1Rate = load.voteReturn.data[0].percent
                                btn2Rate = load.voteReturn.data[1].percent
                            }
                        }catch(let err){
                            print(err)
                        }
                    }
                    onceClicked = true
                }) {
                    HStack{
                        Text(btn2Content)
                        Spacer()
                        Text(isBtnClicked != 0 ? String(format: "%.1f", btn2Rate) + "%" : "")
                    }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 10)
                        .padding(.trailing, 10)
                        .foregroundColor(btn1Rate<btn2Rate ? .black : Color("signupText"))
                        .font(.system(size: 15))
                        .frame(width: 230, height: 40, alignment: .center)
                        .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(red: 0.669, green: 0.739, blue: 0.929), lineWidth: 4))
                        .background(isBtnClicked == 2 ? Color(red: 0.913, green: 0.938, blue: 1.002) : Color(.white))
                }.cornerRadius(10)
            }
        }.padding(.leading, 45)
    }
}

struct ScrollViewItem_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewItem(token:String(), content: String(), id: Int(), btn1Content: String(), btn2Content: String())
    }
}
