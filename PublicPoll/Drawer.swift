//
//  Drawer.swift
//  PublicPoll
//
//  Created by 정우 on 2022/05/20.
//

import SwiftUI

struct Drawer: View {
    @State var isDrawerOpen: Bool = false
    
    var body: some View {
        ZStack{
            if !self.isDrawerOpen{
                NavigationView{
                    EmptyView()
                        .navigationTitle(Text("Navigation Drawer"))
                        .navigationBarItems(leading: Button(
                            action: {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                                    self.isDrawerOpen.toggle()
                                }
                            }){
                                Image(systemName: "sidebar.left")
                            })
                }
            }
            NavigationDrawer(isOpen: self.isDrawerOpen)
        }
        .background(Color.white)
        .onTapGesture {
            if self.isDrawerOpen{
                self.isDrawerOpen.toggle()
            }
        }
    }
}

struct Drawer_Previews: PreviewProvider {
    static var previews: some View {
        Drawer()
    }
}

struct DrawerContent: View{
    var body: some View{
        Color("lavender")
    }
}

struct NavigationDrawer: View{
    private let width =  UIScreen.main.bounds.width - 150
    let isOpen: Bool
    
    var body: some View{
        ZStack{
            HStack{
                DrawerContent()
                    .ignoresSafeArea()
                    .frame(width: self.width)
                    .offset(x: self.isOpen ? 0 : -self.width)
                    .animation(.default)
                Spacer()
            }
        }
        
    }
}

extension View{
    func getRect()->CGRect{
        return UIScreen.main.bounds
    }
}
