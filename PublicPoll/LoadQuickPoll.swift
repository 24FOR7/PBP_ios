//
//  LoadQuickPoll.swift
//  PublicPoll
//
//  Created by 정우 on 2022/05/27.
//

//{"statusCode":200,
//    "resMessage":"빠른투표 반환 성공",
//    "data":[
//        {
//            "id":81,  --> 투표 번호
//            "nick":"aaaaa",   --> 작성자
//            "tier":1, --> 작성자 이름
//            "contents":"helllllllo",
//            "hashTag":[
//                {
//                    "id":134,
//                    "name":"ccc",
//                    "polls":null
//                },
//                {
//                    "id":135,
//                    "name":"bbb",
//                    "polls":null
//                },
//                {
//                    "id":133,
//                    "name":"aaa",
//                    "polls":null
//                }
//            ],
//            "endTime":"2007-12-03T10:15:30",
//            "hasImage":false,
//            "isPublic":true,
//            "showNick":true,
//            "canRevote":false,
//            "canComment":false,
//            "isSingleVote":true,
//            "createdAt":"2022-05-20T09:33:45.320248",
//            "items":[ --> 2개 중 택 1
//                {
//                    "contents":"coooooontents",
//                    "id":82,
//                    "poll_id":81,
//                    "item_num":1,
//                    "has_image":false
//                },
//                {
//                    "contents":"thisconttt",
//                    "id":83,
//                    "poll_id":81,
//                    "item_num":2,
//                    "has_image":true
//                }
//            ],
//            "myBallots":null,
//            "stats":null
//        },
//    ]
//}

import Foundation
import SwiftUI
import Combine


class LoadQuickPoll: ObservableObject{
    @Published var authenticated = false
    
    func getPolls(token: String) -> Bool{
            guard let url = URL(string: "http://13.209.119.116:8080/poll/speed") else { return false}
        var success = false
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("데이터가 존재하지 않습니다.")
                return
            }
            
            //2. 오류 확인
            guard error == nil else {
                print("오류 : \(String(describing: error))")
                return
            }
            
            //3. http응답을 받음
            guard let response = response as? HTTPURLResponse else {
                print("잘못된 응답입니다.")
                return
            }
            
            //4. 응답 상태
            //Successful response = 200 ~ 299
            guard response.statusCode >= 200 && response.statusCode < 300 else {
                print("Status Code는 2xx이 되야 합니다. 현재 Status Code는 \(response.statusCode) 입니다.")
                return
            }
            print("데이터를 성공적으로 다운로드 했습니다!")
            print(data)
            //data를 문자열로 변환해줘야 합니다.
            let jsonString = String(data: data, encoding: .utf8)
            print(jsonString)
            success = true
                //completionHandler(true, output.result)
            }.resume()
        return success
    }
    
    func quickVote(token: String, pollId: Int, itemNum: [Int]){
        guard let url = URL(string: "http://13.209.119.116:8080/ballot/add") else { return}
        
        let body: [String: Any] = ["pollId": pollId, "itemNum": itemNum]
        
            let finalBody = try! JSONSerialization.data(withJSONObject: body)

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = finalBody
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "Authorization")

            URLSession.shared.dataTask(with: request) { (data, response, error) in
                //1. 데이터 확인
                            guard let data = data else {
                                print("데이터가 존재하지 않습니다.")
                                return
                            }
                            
                            //2. 오류 확인
                            guard error == nil else {
                                print("오류 : \(String(describing: error))")
                                return
                            }
                            
                            //3. http응답을 받음
                            guard let response = response as? HTTPURLResponse else {
                                print("잘못된 응답입니다.")
                                return
                            }
                            
                            //4. 응답 상태
                            //Successful response = 200 ~ 299
                            guard response.statusCode >= 200 && response.statusCode < 300 else {
                                print("Status Code는 2xx이 되야 합니다. 현재 Status Code는 \(response.statusCode) 입니다.")
                                return
                            }
                            print("투표가 성공적으로 완료되었습니다!")
                            print(data)
                            
                            
        }.resume()
    }
}
