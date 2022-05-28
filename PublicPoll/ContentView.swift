//
//  ContentView.swift
//  PublicPoll
//
//  Created by 정우 on 2022/05/17.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationView{
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
                        Image("logo")
                            .resizable()
                            .frame(
                                width: 220, height: 220, alignment: .center)
                            .padding(.bottom, 180.0)
                        Text("Start Public Poll")
                            .foregroundColor(Color.white)
                        
                        HStack{
                            NavigationLink(
                                destination: SignIn()
                            ){
                                Image("login_pbp")
                                    .resizable()
                                    .frame(width: 50, height: 50, alignment: .center)
                            }
                            
                            Image("login_google")
                                .resizable()
                                .frame(width: 50, height: 50, alignment: .center)
                                .padding(10)
                            
                            Image("login_facebook")
                                .resizable()
                                .frame(width: 50, height: 50, alignment: .center)
                        }
                    }
                }
            }
        }
        
        	
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}
