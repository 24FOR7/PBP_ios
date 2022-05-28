//
//  SignUpHTTP.swift
//  PublicPoll
//
//  Created by 정우 on 2022/05/24.
//

import Foundation
import SwiftUI
import Combine

class SignUpHTTP: ObservableObject{
    @Published var authenticated = false
    
    func postAuth(token: String, email: String, nick: String, age: Int, gender: String, interest1: String, interest2: String, interest3: String) -> Bool{
            guard let url = URL(string: "http://13.209.119.116:8080/user/signUp") else { return false}
        var success = false
        let tier: Int = 1

        let body: [String: Any] = ["email": email, "nick": nick, "age": age, "gender": gender, "tier": tier, "user_interest1": interest1, "user_interest2": interest2, "user_interest3": interest3]
        
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
                            print("데이터를 성공적으로 다운로드 했습니다!")
                            print(data)
                            //data를 문자열로 변환해줘야 합니다.
                            let jsonString = String(data: data, encoding: .utf8)
                            print(jsonString)
                            success = true
        }.resume()
        return success
    }
}
