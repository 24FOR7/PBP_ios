//
//  Home.swift
//  PublicPoll
//
//  Created by 정우 on 2022/05/19.
//

import SwiftUI
import Firebase

struct Home: View {
    @State var isDrawerOpen: Bool = false
    @State var token: String = "no token"
    @State var list = QuickRes()
    
    @StateObject var load = LoadQuickPoll()
    @State var boolList = [0,0,0,0,0,0,0,0,0,0,0,0]
    
    var body: some View {
        GeometryReader{ geo in
                ZStack{
                    Image("background_whole")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                        .frame(width: geo.size.width,
                               height: geo.size.height,
                               alignment: .center)
                        .opacity(1.0)
                    
                    VStack{
                        ZStack{
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color("softGray"))
                                .ignoresSafeArea()
                                .padding(.top, 10)
                                
                            VStack{
                                ScrollView(.horizontal, showsIndicators: false, content: {
                                    HStack{
                                        ForEach(load.res.data, id:\.self)  { data in
                                            ZStack{
                                                RoundedRectangle(cornerRadius: 15)
                                                    .fill(Color.white)
                                                    .frame(width: 300, height: 330)
                                                VStack{
                                                    Text(data.contents)
                                                        .font(.system(size: 25))
                                                        .frame(width: 230, alignment: .leading)
                                                        .fixedSize(horizontal: false, vertical: true)
                                                        .padding(.bottom, 30)
                                                    Button(action: {
                                                        let itemNum:[Int] = [1]
                                                        load.quickVote(token: token, pollId: data.id, itemNum: itemNum)
                                                    }) {
                                                        Text(data.items[0].contents)
                                                            .frame(maxWidth: .infinity, alignment: .leading)
                                                            .padding(.leading, 10)
                                                            .foregroundColor(Color("signupText"))
                                                            .font(.system(size: 15))
                                                            .frame(width: 230, height: 40, alignment: .center)
                                                            .overlay(RoundedRectangle(cornerRadius: 10)
                                                                .stroke(Color(red: 0.704, green: 0.714, blue: 0.909), lineWidth: 4))
                                                            .background(.white)
                                                    }.cornerRadius(10)
                                                        .padding(.bottom, 10)
                                                        
                                                    Button(action: {
                                                        let itemNum:[Int] = [2]
                                                        load.quickVote(token: token, pollId: data.id, itemNum: itemNum)
                                                        
                                                    }) {
                                                        Text(data.items[1].contents)
                                                            .frame(maxWidth: .infinity, alignment: .leading)
                                                            .padding(.leading, 10)
                                                            .foregroundColor(Color("signupText"))
                                                            .font(.system(size: 15))
                                                            .frame(width: 230, height: 40, alignment: .center)
                                                            .overlay(RoundedRectangle(cornerRadius: 10)
                                                                .stroke(Color(red: 0.669, green: 0.739, blue: 0.929), lineWidth: 4))
                                                    }.cornerRadius(10)
                                                }
                                            }.padding(.leading, 45)
                                        }
                                    }
                                }).onAppear{
                                    let currentUser = Auth.auth().currentUser
                                    currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
                                      if let error = error {
                                        print("error")
                                      }
                                        else{
                                            token = idToken!
                                            load.getPolls(token: token)
                                        }
                                        
                                    }
                                }
                                .padding(.bottom, 10)
                                    .padding(.top, 10)
                                
                                HStack{
                                    NavigationLink(destination: Text("Search"), label: {
                                        Button(action: {}){
                                            VStack{
                                                Image("icon_search")
                                                    .resizable()
                                                    .frame(width: 30, height: 30, alignment: .center)
                                                Text("Search")
                                                    .font(.system(size: 12))
                                                    .foregroundColor(.gray)
                                            }
                                                .frame(width: 140, height: 100)
                                                .background(.white)
                                                .cornerRadius(15)
                                                .padding(.trailing, 10)
                                        }
                                    })
                                    NavigationLink(destination: Text("Hot Polls"), label: {
                                        VStack{
                                            Image("icon_hot")
                                                .resizable()
                                                .frame(width: 30, height: 30, alignment: .center)
                                            Text("Hot Polls")
                                                .font(.system(size: 12))
                                                .foregroundColor(.gray)
                                        }
                                            .frame(width: 140, height: 100) 
                                            .background(.white)
                                            .cornerRadius(15)
                                            .padding(.leading, 10)
                                    })
                                }.padding(.bottom, 10)
                                
                                //all votes
                                NavigationLink(destination: Home(), label: {
                                    HStack{
                                        Image("icon_all_polls")
                                            .resizable()
                                            .frame(width: 25, height: 25, alignment: .center)
                                        Text("All Polls")
                                            .font(.system(size: 20))
                                            .foregroundColor(Color(red: 0.714, green: 0.714, blue: 0.714))
                                    }
                                        .frame(width: 310, height: 64)
                                        .background(Color("deepGray"))
                                        .cornerRadius(15)
                                }).padding(.bottom, 10)
                                
                                //create new vote
                                NavigationLink(destination: NewPoll(token: token), label: {
                                    HStack{
                                        Image("icon_edit")
                                            .resizable()
                                            .frame(width: 40, height: 40, alignment: .center)
                                        VStack{
                                            Text("New Poll")
                                                .bold()
                                                .font(.system(size: 22))
                                                .foregroundColor(.white)
                                            Text("Add your own poll")
                                                .font(.system(size: 8))
                                                .foregroundColor(.white)
                                        }
                                        
                                    }
                                        .frame(width: 310, height: 100)
                                        .background(Color("lavender"))
                                        .cornerRadius(15)
                                })
                            }
                        }
                    }
            }
                .navigationBarTitleDisplayMode(.inline)
                    .toolbar{
                        ToolbarItem(placement: .principal){
                            VStack{
                                Image("logo_pbp_letter")
                                    .resizable()
                                    .frame(width: 57, height: 26, alignment: .center)
                            }
                        }
                    }
                    .navigationBarItems(leading: Button(
                        action: {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                                self.isDrawerOpen.toggle()
                            }
                        }){
                            Image("icon_menu")
                                .resizable()
                                .frame(width: 30, height: 23)
                        })
            
        }
    }
    
    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
