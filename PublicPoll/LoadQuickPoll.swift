//
//  LoadQuickPoll.swift
//  PublicPoll
//
//  Created by 정우 on 2022/05/27.
//
import Foundation
import SwiftUI
import Combine


class LoadQuickPoll: ObservableObject{
    @Published var authenticated = false
    @Published var res:QuickRes = QuickRes()
    
    
    func getPolls(token: String) -> QuickRes{
        @State var result = QuickRes()
        guard let url = URL(string: "http://13.209.119.116:8080/poll/speed") else { return result}
        var success = false
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
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
            
            do{
                //result = try JSONDecoder().decode(QuickRes.self, from: data)
                let re = try JSONDecoder().decode(QuickRes.self, from: data)
                DispatchQueue.main.async {
                    self?.res = re
                }
                //print(result.data[0].id)
            }catch(let err){
                print(err)
            }
            
            print("데이터를 성공적으로 다운로드 했습니다!")
            
            //data를 문자열로 변환해줘야 합니다.
            let jsonString = String(data: data, encoding: .utf8)
            success = true
                //completionHandler(true, output.result)
            }.resume()
        return result
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
                
                            
                            
        }.resume()
    }
}
