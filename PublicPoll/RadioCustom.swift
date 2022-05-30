//
//  RadioCustom.swift
//  PublicPoll
//
//  Created by 정우 on 2022/05/30.
//

import Foundation
import SwiftUI

//라디오 버튼 커스텀 디자인
struct RadioButton: View{
    let id: String
    let label: String
    let size: CGFloat
    let iconColor: Color
    let textSize: CGFloat
    let isMarked: Bool
    let callback: (String)->()
    let width:CGFloat
    
    init(
        id: String,
        label: String,
        width: CGFloat,
        textSize: CGFloat,
        size: CGFloat = 16,
        iconColor: Color = Color("lavender"),
        isMarked: Bool = false,
        callback: @escaping (String)->()
    ){
        self.id = id
        self.label = label
        self.width = width
        self.textSize = textSize
        self.size = size
        self.iconColor = iconColor
        self.isMarked = isMarked
        self.callback = callback
    }
    
    var body: some View{
        Button(action: {
            self.callback(self.id)
        }){
            HStack(alignment: .center, spacing: 4){
                Image(systemName: self.isMarked ?
                      "largecircle.fill.circle" : "circle")
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: self.size, height: self.size)
                .foregroundColor(self.iconColor)
            
                Text(label)
                    .font(Font.system(size: textSize))
                    .foregroundColor(Color("signupText"))
                    .bold()
                
            }
        }.foregroundColor(.white)
            .frame(width: width, alignment: .leading)
    }
}
