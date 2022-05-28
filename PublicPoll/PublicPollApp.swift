//
//  PublicPollApp.swift
//  PublicPoll
//
//  Created by 정우 on 2022/05/17.
//

import SwiftUI
import Firebase
import FirebaseAuth

@main
struct PublicPollApp: App {
    init() {
            FirebaseApp.configure() // 파이어베이스 초기화
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
