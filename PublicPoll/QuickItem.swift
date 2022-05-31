//
//  QuickItem.swift
//  PublicPoll
//
//  Created by 정우 on 2022/05/28.
//

import Foundation

struct QuickRes: Hashable,Codable {
    var statusCode: Int = 0
    var resMessage: String = ""
    var data: [QuickItem] = [QuickItem()]
}

struct QuickItem: Hashable,Codable {
    var id: Int = 0
    var nick: String = ""
    var tier: Int = 0
    var contents: String = ""
    var hashTag: [QuickHashTag] = [QuickHashTag()]
    var endTime: String = ""
    var hasImage: Bool = false
    var isPublic: Bool = false
    var showNick: Bool = false
    var canRevote: Bool = false
    var canComment: Bool = false
    var isSingleVote: Bool = false
    var createdAt: String = ""
    var items: [ItemList] = [ItemList(),ItemList()]
}

struct QuickHashTag: Hashable,Codable {
    var id: Int = 0
    var name: String = ""
}

struct ItemList: Hashable,Codable {
    var contents: String = ""
    var id: Int = 0
    var pollID: Int = 0
    var itemNum: Int = 0
    var hasImage: Bool = false
    
    enum CodingKeys: String, CodingKey {
            case contents, id
            case pollID = "poll_id"
            case itemNum = "item_num"
            case hasImage = "has_image"
        }
}

struct HashTagItem: Hashable,Codable{
    var name: String = ""
    var id: Int = 0
    var p: String = ""
}

struct MyBallots: Hashable,Codable{
    
}

struct Stats: Hashable,Codable{
    
}

struct VoteReturn: Codable {
    let statusCode: Int
    let resMessage: String
    let data: [VoteReturnData]
}

struct VoteReturnData: Codable {
    let itemNum, optionTotalCnt, optionItemCnt, percent: Int
    let isBest: Bool
}

